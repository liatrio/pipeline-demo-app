#!/bin/env groovy
library 'pipeline-library@rich-slack'
pipeline {
  agent any
  environment {
      SLACK_ROOM = "GDS3Y1T43"
      SLACK_WEBHOOK_URL = "https://liatrio.slack.com"
      SLACK_TOKEN = credentials("pipeline-pal-slack")
  }
  stages {
    stage('Maven: Build and push artifact to Artifactory') {
      steps {
        script {
          messages = sendSlackPipeline()
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage('Maven: Analyze code with Sonar') {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage('Build Docker image') {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage('Push docker image to Artifactory') {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage('Spin up local container for automated testing') {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage('Functional test With Selenium') {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage('Gatling performance test') {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage('Spin down container used for testing') {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage('Maven: Promote artifact from snapshot to release in Artifactory') {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage("Provisioning test environment") {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage("Deploying to test environment") {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage('Selenium smoke test') {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
     }
     stage("Waiting for manual test environment validation") {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
    stage("Destroying test environment") {
      steps {
        script {
          try {
            sendStageRunning(messages)
            sleep 10
            sendStageSuccess(messages)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), messages)
            throw err
          }
        }
      }
    }
  }
}
