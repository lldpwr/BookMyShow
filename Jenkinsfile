
pipeline {
  environment {
    registry = 'lldpwr/jenkinsdockerpowershell'
    registryCredential = 'dockerhub'
    githubCredential = "github"
    dockerImage = ""
  }
  agent any
  stages {
    stage("Cloning Git") {
      steps {
        script {
            properties([pipelineTriggers([pollSCM("H 21 * * *")])])
        }
        git branch: "Develop", credentialsId: githubCredential, url: "git@github.com:lldpwr/BookMyShow.git"
      }
    }
    stage("Building image") {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage("run and test image") {
      steps{
        script {
            dockerImage.inside("-p 8086:8086") {
                sh "pwsh tests/request.ps1"
            }
        }
      }
    }
    stage("Deploy Image") {
      steps{
        script {
          docker.withRegistry( "", registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
  }
}

