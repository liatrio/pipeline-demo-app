#!/bin/env groovy
library 'pipeline-library@rich-slack'
pipeline {
    agent any
    environment {
        SLACK_ROOM = "jeff"
        SLACK_WEBHOOK_URL = credentials("jeff-slack-webhook")
        SLACK_TOKEN = credentials("pipeline-pal-slack")
    }
    stages {
        stage('Maven: Build and push artifact to Artifactory') {
            steps {
                slackMessage([
                  event: "build-start",
                  token:  "${env.SLACK_TOKEN}",
                  channel: "${env.SLACK_ROOM}",
                  slackURL: "${env.SLACK_WEBHOOK_URL}",
                  message: "Maven: Build and push artifact to Artifactory"
                ])
                sleep 5
                slackMessage([
                  event: "build-complete",
                  token: credentials("pipeline-pal-slack-token"),
                  channel: "${env.SLACK_ROOM}",
                  slackURL: "${env.SLACK_WEBHOOK_URL}",
                  message: "Maven build complete"
                ])
            }
        }
        stage('Maven: Analyze code with Sonar') {

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
 
             steps {
                 sleep 5
             }
        }
        stage('Gatling performance test') {

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
