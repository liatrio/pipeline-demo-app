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
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /******** ****************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage('Maven: Analyze code with Sonar') {
            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage('Build Docker image') {
            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage('Push docker image to Artifactory') {
            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage('Spin up local container for automated testing') {
            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage('Functional test With Selenium') {
 
             steps {
              sendStageRunning("running", messages)
              /************************************************************/
               sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
             }
        }
        stage('Gatling performance test') {

            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage('Spin down container used for testing') {
            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage('Maven: Promote artifact from snapshot to release in Artifactory') {

            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage("Provisioning test environment") {
            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage("Deploying to test environment") {
            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage('Selenium smoke test') {
           steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
           }
         }
         stage("Waiting for manual test environment validation") {
            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
        stage("Destroying test environment") {
            steps {
              sendStageRunning("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              sendStageSuccess("passed", messages)
            }
        }
    }
}
