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
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /******** ****************************************************/
              updateMessage("passed", messages)
            }
        }
        stage('Maven: Analyze code with Sonar') {
            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
        stage('Build Docker image') {
            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
        stage('Push docker image to Artifactory') {
            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
        stage('Spin up local container for automated testing') {
            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
        stage('Functional test With Selenium') {
 
             steps {
              updateMessage("running", messages)
              /************************************************************/
               sleep 10
              /************************************************************/
              updateMessage("passed", messages)
             }
        }
        stage('Gatling performance test') {

            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
        stage('Spin down container used for testing') {
            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
        stage('Maven: Promote artifact from snapshot to release in Artifactory') {

            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
        stage("Provisioning test environment") {
            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
        stage("Deploying to test environment") {
            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
        stage('Selenium smoke test') {
           steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
           }
         }
         stage("Waiting for manual test environment validation") {
            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
        stage("Destroying test environment") {
            steps {
              updateMessage("running", messages)
              /************************************************************/
              sleep 10
              /************************************************************/
              updateMessage("passed", messages)
            }
        }
    }
}
