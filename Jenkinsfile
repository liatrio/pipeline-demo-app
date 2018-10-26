#!/bin/env groovy
library 'pipeline-library@rich-slack'
pipeline {
    agent any
    environment {
        APP_NAME = "__APP_NAME__"
        PROJECT_KEY = "__PROJECT_KEY__"
        DEMO_APP_PATH = "personal-banking"
        IMAGE = "${APP_NAME}-demo"
        DEV_IP = "dev.${APP_NAME}.liatr.io"
        SONAR_URL = 'http://sonarqube.liatr.io'
        TAG = ''
        JIRA_ISSUE = ''
        JIRA_URL = 'http://jira.liatr.io'
        ARTIFACTORY_URL = 'https://artifactory.liatr.io'
        BITBUCKET_URL = "http://bitbucket.liatr.io/projects/${PROJECT_KEY}/repos/pipeline-demo-application"
        DOCKER_REPO = "docker.artifactory.liatr.io"
        AWS_ACCESS_KEY_ID = credentials('AWSaccess')
        AWS_SECRET_ACCESS_KEY = credentials('AWSsecret')
        SNYK_TOKEN = credentials('snyk')
        AWS_DEFAULT_REGION = 'us-west-2'
        GROUP_ID = ''
        ARTIFACT_ID = ''
        VERSION = ''
        STAGE = ''
        SLACK_ROOM = "jeff"
    }
    stages {
        stage('Maven: Build and push artifact to Artifactory') {
            agent any
            steps {
                sleep 5
                  slackMessage([
                    event: "buld-complete",
                    channel: env.SLACK_ROOM,
                    message: "Maven build complete"
                  ])
            }
        }
        stage('Maven: Analyze code with Sonar') {
            agent any
            steps {
                sleep 5
            }
        }
        stage('Build Docker image') {
            steps {
                sleep 5
            }
        }
        stage('Push docker image to Artifactory') {
            steps {
                sleep 5
            }
        }
        stage('Spin up local container for automated testing') {
            steps {
                sleep 5
            }
        }
        stage('Functional test With Selenium') {
             agent any
             steps {
                 sleep 5
             }
        }
        stage('Gatling performance test') {
            agent any
            steps {
                sleep 5
            }
        }
        stage('Spin down container used for testing') {
            steps {
                sleep 5
            }
        }
        stage('Maven: Promote artifact from snapshot to release in Artifactory') {
            agent any
            steps {
                sleep 5
            }
        }
        stage("Provisioning test environment") {
            steps {
                sleep 5
            }
        }
        stage("Deploying to test environment") {
            steps {
                sleep 5
            }
        }
        stage('Selenium smoke test') {
           agent any
           steps {
               sleep 5
           }
         }
         stage("Waiting for manual test environment validation") {
            steps {
                sleep 5
            }
        }
        stage("Destroying test environment") {
            steps {
                sleep 5
            }
        }
    }
}
