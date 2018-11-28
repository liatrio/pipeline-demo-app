#!/bin/env groovy
library 'pipeline-library@rich-slack-2'
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
          message = sendSlackPipeline()
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage('Maven: Analyze code with Sonar') {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            coverage = "Code Coverage" + Math.abs(new Random().nextInt() % 100) + 1
            message = sendStageSuccess(message, coverage)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage('Build Docker image') {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage('Push docker image to Artifactory') {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage('Spin up local container for automated testing') {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage('Functional test With Selenium') {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage('Gatling performance test') {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage('Spin down container used for testing') {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage('Maven: Promote artifact from snapshot to release in Artifactory') {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage("Provisioning test environment") {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage("Deploying to test environment") {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage('Selenium smoke test') {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
     }
     stage("Waiting for manual test environment validation") {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
    stage("Destroying test environment") {
      steps {
        script {
          try {
            message = sendStageRunning(message)
            sleep 10
            message = sendStageSuccess(message)
          }
          catch(err){
            sendPipelineFailure(err.getMessage(), message)
            throw err
          }
        }
      }
    }
  }
}
