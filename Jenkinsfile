#!/bin/env groovy
library 'pipeline-library'
pipeline {
    agent none
    environment {
        APP_NAME = "personal-banking"
        PROJECT_NAME = ""
        IMAGE = "${APP_NAME}-demo"
        DEV_IP = "dev.${APP_NAME}.liatr.io"
        SONAR_URL = 'http://sonarqube.liatr.io'
        TAG = ''
        JIRA_ISSUE = ''
        JIRA_URL = 'http://jira.liatr.io'
        ARTIFACTORY_URL = 'https://artifactory.liatr.io'
        BITBUCKET_URL = "http://bitbucket.liatr.io/projects/${PROJECT_NAME}/repos/${APP_NAME}"
        DOCKER_REPO = "docker.artifactory.liatr.io"
        AWS_ACCESS_KEY_ID = credentials('AWSaccess')
        AWS_SECRET_ACCESS_KEY = credentials('AWSsecret')
        SNYK_TOKEN = credentials('snyk')
        AWS_DEFAULT_REGION = 'us-west-2'
        GROUP_ID = ''
        ARTIFACT_ID = ''
        VERSION = ''
        STAGE = ''
        SLACK_ROOM = "${APP_NAME}-demo"
    }
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.5.0'
                }
            }
            steps {
                script {
                    STAGE = env.STAGE_NAME
                    JIRA_ISSUE = getJiraIssue()
                    echo "jira issue ${JIRA_ISSUE}"
                    def gitUrl = env.GIT_URL ? env.GIT_URL: env.GIT_URL_1
                    slackSend channel: env.SLACK_ROOM, message: "Triggered build of ${env.GIT_BRANCH} from <${BITBUCKET_URL}/commits/${env.GIT_COMMIT}|commit>. Follow progress <${RUN_DISPLAY_URL}|here>"
                    withCredentials([usernamePassword(credentialsId: 'Artifactory', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh "mvn clean deploy -B -DartifactoryUsername=$USERNAME -DartifactoryPassword=$PASSWORD"
                    }
                    junit 'target/surefire-reports/*.xml'
                    jacoco()
                    slackSend channel: env.SLACK_ROOM, message: "Success: Build complete"
                }
            }
        }
        stage('Analyze Code with Sonar') {
            agent {
                docker {
                    image 'maven:3.5.0'
                }
            }
            steps {
                script {
                    STAGE = env.STAGE_NAME
                    withCredentials([string(credentialsId: 'sonarqube', variable: 'sonarqubeToken')]) {
                        sh "mvn sonar:sonar -Dsonar.login=${sonarqubeToken}"
                    }
                    pom = readMavenPom file: 'pom.xml'
                    slackSend channel: env.SLACK_ROOM, message: "Success: Sonarqube scan complete - <${env.SONAR_URL}/dashboard?id=${pom.groupId}%3A${pom.artifactId}|view project>"
                }
            }
        }
        stage('Build container') {
            agent any
            steps {
                script {
                    STAGE = env.STAGE_NAME
                    pom = readMavenPom file: 'pom.xml'
                    TAG = pom.version
                    sh "docker build -t ${env.DOCKER_REPO}/${env.IMAGE}:${TAG} ."
                }
            }
        }
        stage('Push to Artifactory') {
            agent any
            steps {
                script {
                    STAGE = env.STAGE_NAME
                    withCredentials([usernamePassword(credentialsId: 'Artifactory', passwordVariable: 'artifactoryPassword', usernameVariable: 'artifactoryUsername')]) {
                        sh "docker login -u ${env.artifactoryUsername} -p ${env.artifactoryPassword} ${DOCKER_REPO}"
                        sh "docker push ${env.DOCKER_REPO}/${env.IMAGE}:${TAG}"
                    }
                    slackSend channel: env.SLACK_ROOM, message: "Success: Container pushed to <${env.ARTIFACTORY_URL}/artifactory/webapp/#/artifacts/browse/tree/General/docker-local/${env.IMAGE}/${TAG}|artifactory>"
                }
            }
        }
        stage('Run container') {
            agent any
            steps {
                sh "docker network create demo || true"
                script {
                    STAGE = env.STAGE_NAME
                    runAppLocally(appName: "${APP_NAME}", imageName: "${env.IMAGE}", imageVersion: "${TAG}")
                    slackSend channel: env.SLACK_ROOM, message: "Running container locally for further testing"
                }
                sh "echo \$(docker inspect --format='{{ .NetworkSettings.Networks.demo.IPAddress }}' \$(docker ps -q --filter name=${APP_NAME})) > APP_IP_ADDRESS"
            }
        }
        stage('Functional test With Selenium') {
            agent {
                docker {
                    image 'maven:3.5.0'
                    args '--net demo'
                }
            }
            steps {
                script { STAGE = env.STAGE_NAME }
                sh "cd regression-suite && \
                mvn clean -B test -DPETCLINIC_URL=http://${APP_NAME}:8080/${APP_NAME} -Dcucumber.options='--tags ~@smoke'"
                cucumber fileIncludePattern: 'regression-suite/**/*.json', sortingMethod: 'ALPHABETICAL'
                slackSend channel: env.SLACK_ROOM, message: "Success: Functional test complete"
            }
        }
        stage('Performance test with Gatling') {
            agent {
                docker {
                    image 'denvazh/gatling'
                    args "-u 0:0 --net demo"
                }
            }
            steps {
                script { STAGE = env.STAGE_NAME }
                sh '''
                   export APP_IP_ADDRESS=$(cat APP_IP_ADDRESS) && \\
                   mv BasicSimulation.scala /opt/gatling/user-files/simulations/computerdatabase/BasicSimulation.scala && \
                   gatling.sh -s computerdatabase.BasicSimulation
                   '''
                gatlingArchive()
                slackSend channel: env.SLACK_ROOM, message: "Success: Performance test complete"
            }
        }
        stage('Snyk Scan') {
            agent {
                docker {
                    image 'maven:3.5.0'
                }
            }
            steps {
                script { STAGE = env.STAGE_NAME }
                sh "mvn snyk:test -DSNYK_API_TOKEN=${SNYK_TOKEN}"
            }
        }
        stage('Spin down container') {
            agent any
            steps {
                script {
                    STAGE = env.STAGE_NAME
                }
                sh "docker stop ${APP_NAME} || true"
                sh 'docker network rm demo || true'
            }
        }
        stage('Promote Artifact') {
            agent {
                docker {
                    image 'maven:3.5.0'
                }
            }
            when { branch 'master' }
            steps {
                script {
                    STAGE = env.STAGE_NAME
                    pom = readMavenPom file: 'pom.xml'
                    VERSION = pom.version.replaceAll("SNAPSHOT", "RELEASE")
                    GROUP_ID = pom.groupId
                    ARTIFACT_ID = pom.artifactId
                    PROMOTE_URL = "releases"
                }
                configFileProvider([configFile(fileId: 'artifactory', variable: 'MAVEN_SETTINGS')]) {
                    sh "mvn -s $MAVEN_SETTINGS deploy:deploy-file -DgroupId=$GROUP_ID -DartifactId=$ARTIFACT_ID -Dversion=$VERSION -DrepositoryId=releases -Dfile=./target/${APP_NAME}.war -Durl=http://artifactory.liatr.io/artifactory/releases"
                }
            }
        }
        stage("Provisioning Feature Branch Environment") {
            agent any
            when { not { branch 'master' } }
            steps {
                script {
                    STAGE = env.STAGE_NAME
                    DEV_IP = "${env.BRANCH_NAME}.${APP_NAME}.liatr.io"
                }
                withCredentials([sshUserPrivateKey(credentialsId: '71d94074-215d-4798-8430-40b98e223d8c', keyFileVariable: 'keyFileVariable', passphraseVariable: '', usernameVariable: 'usernameVariable')]) {
                    slackSend channel: env.SLACK_ROOM, message: "Provisioning feature branch environment"
                    sh "export TF_VAR_key_file=${keyFileVariable} && export TF_VAR_tag=${TAG} && export TF_VAR_instance_name=${env.BRANCH_NAME} && ./terraform.sh"
                }
            }
        }
        stage("Deploying to Environment") {
            agent any
            steps {
                script { STAGE = env.STAGE_NAME }
                withCredentials([sshUserPrivateKey(credentialsId: '71d94074-215d-4798-8430-40b98e223d8c', keyFileVariable: 'keyFileVariable', passphraseVariable: '', usernameVariable: 'usernameVariable')]) {
                    withCredentials([usernamePassword(credentialsId: 'Artifactory', passwordVariable: 'artifactoryPassword', usernameVariable: 'artifactoryUsername')]) {
                        script {
                            sh "ssh -o StrictHostKeyChecking=no -i $keyFileVariable $usernameVariable@${DEV_IP} docker login -u ${artifactoryUsername} -p ${artifactoryPassword} ${DOCKER_REPO}"
                        }
                    }
                    sh "ssh -o StrictHostKeyChecking=no -i $keyFileVariable $usernameVariable@${DEV_IP} docker pull ${DOCKER_REPO}/${env.IMAGE}:${TAG}"
                    sh "ssh -o StrictHostKeyChecking=no -i $keyFileVariable $usernameVariable@${DEV_IP} 'docker rm -f ${APP_NAME} || sleep 5'"
                    sh "ssh -o StrictHostKeyChecking=no -i $keyFileVariable $usernameVariable@${DEV_IP} 'docker ps -a || sleep 5'"
                    sh "ssh -o StrictHostKeyChecking=no -i $keyFileVariable $usernameVariable@${DEV_IP} 'docker run --rm -d --name ${APP_NAME} -p 80:8080 ${DOCKER_REPO}/${env.IMAGE}:${TAG}'"
                }
                script {
                    try {
                        jiraComment body: "Deployed ${env.IMAGE}:${TAG} to http://${DEV_IP}/${APP_NAME}", issueKey: "${JIRA_ISSUE}"
                    }
                    catch (e) {
                        echo "No Jira Ticket"
                    }
                }
                slackSend channel: env.SLACK_ROOM, color: 'good', message: "Success: Deployed to http://${DEV_IP}/${APP_NAME} - waiting on Smoke Test"
            }
        }
        stage('Selenium smoke test') {
            agent {
                docker {
                    image 'maven:3.5.0'
                }
            }
            steps {
                script {
                    STAGE = env.STAGE_NAME
                    sh "cd regression-suite && \
                    mvn clean -B test -DPETCLINIC_URL=http://${DEV_IP}/${APP_NAME}/ -Dcucumber.options='--tags @smoke'"
                    slackSend channel: env.SLACK_ROOM, color: 'good', message: "Success: smoke-test completed."
                    if (env.GIT_BRANCH =~ /(PR-[0-9]+)/)
                        slackSend channel: env.SLACK_ROOM, color: 'good', message: "PR is <${BITBUCKET_URL}/pull-requests|ready to merge>"
                    else if (env.GIT_BRANCH != 'master')
                        slackSend channel: env.SLACK_ROOM, color: 'good', message: "Ready to <${BITBUCKET_URL}/pull-requests?create&targetBranch=refs%2Fheads%2Fmaster&sourceBranch=refs%2Fheads%2F${env.GIT_BRANCH}|create a PR>?"
                }
            }
        }
        stage("Ready to destroy ephemeral environment?") {
            agent any
            when { not { branch 'master' } }
            steps {
                script {
                    try {
                        timeout(time: 10, unit: 'MINUTES') {
                            slackSend channel: env.SLACK_ROOM, message: "Waiting 10 minutes to delete feature branch environment. <${RUN_DISPLAY_URL}|click here> to proceed."
                            input "Delete Instance?"
                        }
                    }
                    catch (e) {
                        echo "Instance timeout reached, destroying..."
                    }
                }
            }
        }
        stage("Destroying ephemeral environment") {
            agent any
            when { not { branch 'master' } }
            steps {
                script { STAGE = env.STAGE_NAME }
                withCredentials([sshUserPrivateKey(credentialsId: '71d94074-215d-4798-8430-40b98e223d8c', keyFileVariable: 'keyFileVariable', passphraseVariable: '', usernameVariable: 'usernameVariable')]) {
                    sh "export TF_VAR_key_file=${keyFileVariable} && export TF_VAR_tag=${TAG} && export TF_VAR_instance_name=${env.BRANCH_NAME} && ./destroy.sh"
                    slackSend channel: env.SLACK_ROOM, message: "Deleted feature branch environment"
                }
            }
        }
    }
    post {
        failure {
            slackSend channel: env.SLACK_ROOM, color: 'danger', message: "Pipeline failed at stage: <${RUN_DISPLAY_URL}|${STAGE}>"
        }
    }
}