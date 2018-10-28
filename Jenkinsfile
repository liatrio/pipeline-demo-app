#!/bin/env groovy
library 'pipeline-library@rich-slack'
pipeline {
    agent any
    environment {
        SLACK_ROOM = "CDPMP2JA1"
        SLACK_WEBHOOK_URL = "https://liatrio.slack.com"
        SLACK_TOKEN = credentials("pipeline-pal-slack")
    }
    stages {
        stage('Maven: Build and push artifact to Artifactory') {
          steps {
            script {
              messages = sendSlackPipeline()
            }
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /******** ****************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage('Maven: Analyze code with Sonar') {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage('Build Docker image') {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage('Push docker image to Artifactory') {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage('Spin up local container for automated testing') {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage('Functional test With Selenium') {
          steps {
           sendStageRunning(messages)
           /************************************************************/
            sleep 10
           /************************************************************/
           sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage('Gatling performance test') {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage('Spin down container used for testing') {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage('Maven: Promote artifact from snapshot to release in Artifactory') {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage("Provisioning test environment") {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage("Deploying to test environment") {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage('Selenium smoke test') {
          steps {
             sendStageRunning(messages)
             /************************************************************/
             sleep 10
             /************************************************************/
             sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
         }
         stage("Waiting for manual test environment validation") {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
        stage("Destroying test environment") {
          steps {
            sendStageRunning(messages)
            /************************************************************/
            sleep 10
            /************************************************************/
            sendStageSuccess(messages)
          }
          post {
            failure {
              sendPipelineFailure(messages)
            }
          }
        }
    }
}
