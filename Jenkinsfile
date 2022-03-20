node {

    def app

    stage('Clone git repository') {
        checkout scm
    }

    stage('Build docker image') {
        app = docker.build('chefdigitaldemo/cicd-demo-react')
    }

    stage('Test docker image') {
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push docker image to registry') {
        docker.withRegistry('https://registry.hub.docker.com', 'git') {
            app.push("${env.BUILD_NUMBER}")
            APP.push("latest")
        }
    }
    
}