#!/bin/env groovy
library 'pipeline-library@rich-slack'
pipeline {
    agent any
    environment {
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
