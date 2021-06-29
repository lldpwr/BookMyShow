
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
            dockerImage.inside {
                sh "pwh 'echo book'"
                sh "pwh 'echo pay'"
                sh "pwh 'echo shudownserver'"
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

