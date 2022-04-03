
pipeline {
  environment {
    registry = 'lldpwr/BookMyShow'
    registryCredential = 'dockerhub'
    githubCredential = "github"
    dockerImage = ""
  }
  agent any
  stages {
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

