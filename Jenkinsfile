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
                messages = sendSlackPipeline([
                    token:  "${env.SLACK_TOKEN}",
                    channel: "${env.SLACK_ROOM}",
                    slackURL: "${env.SLACK_WEBHOOK_URL}"
                  ])
              }
                /************************************************************/
                sleep 10
                /******** ****************************************************/
                //updateMessage([
                //  event: "build-complete",
                //  token: "${env.SLACK_TOKEN}",
                //  messages: messages,
                //  channel: "${env.SLACK_ROOM}",
                //  slackURL: "${env.SLACK_WEBHOOK_URL}",
                //  message: "Maven build complete"
                //])
            }
        }
        stage('Maven: Analyze code with Sonar') {

            steps {
                //updateMessage([
                //  event: "sonar-start",
                //  token: "${env.SLACK_TOKEN}",
                //  messages: messages,
                //  channel: "${env.SLACK_ROOM}",
                //  slackURL: "${env.SLACK_WEBHOOK_URL}",
                //  message: "running sonar analysis"
                //])
                sleep 10
            }
        }
        stage('Build Docker image') {
            steps {
                sleep 10
            }
        }
        stage('Push docker image to Artifactory') {
            steps {
                sleep 10
            }
        }
        stage('Spin up local container for automated testing') {
            steps {
                sleep 10
            }
        }
        stage('Functional test With Selenium') {
 
             steps {
                 sleep 10
             }
        }
        stage('Gatling performance test') {

            steps {
                sleep 10
            }
        }
        stage('Spin down container used for testing') {
            steps {
                sleep 10
            }
        }
        stage('Maven: Promote artifact from snapshot to release in Artifactory') {

            steps {
                sleep 10
            }
        }
        stage("Provisioning test environment") {
            steps {
                sleep 10
            }
        }
        stage("Deploying to test environment") {
            steps {
                sleep 10
            }
        }
        stage('Selenium smoke test') {
           steps {
               sleep 10
           }
         }
         stage("Waiting for manual test environment validation") {
            steps {
                sleep 10
            }
        }
        stage("Destroying test environment") {
            steps {
                sleep 10
            }
        }
    }
}
