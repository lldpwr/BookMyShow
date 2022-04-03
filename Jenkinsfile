
pipeline {
  environment {
    registry = 'lldpwr/bookmyshow'
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
        git branch: "main", credentialsId: githubCredential, url: "https://github.com/lldpwr/BookMyShow.git"
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
            dockerImage.inside{
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

