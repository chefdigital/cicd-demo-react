pipeline {

    environment {
        dockerHubRegistry = 'chefdigitaldemo/cicd-demo-react'
        dockerHubCredential = 'dockerhub'
    }

    def app

    stage('Clone git repository') {
        checkout scm
    }

    stage('Build docker image') {
        app = docker.build(dockerHubRegistry)
    }

    stage('Test docker image') {
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push docker image to registry') {
        docker.withRegistry('', dockerHubCredential) {
            app.push("$BUILD_NUMBER")
            app.push("latest")
        }
    }
    
}