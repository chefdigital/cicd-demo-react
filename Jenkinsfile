pipeline {

    environment {
        gitRepo = 'https://github.com/chefdigital/cicd-demo-react.git'
        gitCredential = 'github-chefdigital'
        dockerHubRegistry = 'chefdigital/cicd-demo-react'
        dockerHubCredential = 'dockerhub-chefdigitaldemo'
        app = ''
    }

    agent any

    stages {
        stage('Clone git repository') {
            steps {
                git([url: gitRepo, branch: 'main', credentialsId: gitCredential])
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
            steps {
                script {
                    docker.withRegistry('', dockerHubCredential) {
                        app.push("$BUILD_NUMBER")
                        app.push("latest")
                    }
                }
            }
        }
    }
    
}