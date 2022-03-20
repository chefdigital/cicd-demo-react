pipeline {

    environment {
        gitRepo = 'https://github.com/chefdigitaldemo/cicd-demo-react.git'
        dockerHubRegistry = 'chefdigitaldemo/cicd-demo-react'
        dockerHubCredential = 'dockerhub'
        app = ''
    }

    agent any

    stages {
        stage('Clone git repository') {
            steps {
                git([url: gitRepo, branch: 'main'])
            }
        }

        stage('Build docker image') {
            steps {
                script {
                    app = docker.build(dockerHubRegistry)
                }
            }
        }

        stage('Push docker image to registry') {
            docker.withRegistry('', dockerHubCredential) {
                app.push("$BUILD_NUMBER")
                app.push("latest")
            }
        }
    }
    
}