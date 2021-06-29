
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
                sh """pwsh -command 'Invoke-WebRequest -Uri http://localhost:8086/Selectitem -Method Post -Body "{ item: 12345 }"  -ContentType "application/json"'"""
                sh """pwsh -command 'Invoke-WebRequest -Uri http://localhost:8086/pay'"""
                sh """pwsh -command 'echo shudownserver'"""
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

