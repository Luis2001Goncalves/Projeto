pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        DOCKER_IMAGE = 'luis01filipe/olamundo-flask'
        KUBE_CONFIG_PATH = 'C:/Programas/Jenkins/.kube/config'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Luis2001Goncalves/Projeto.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    bat 'docker build -t luis01filipe/olamundo-flask .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        bat 'docker push luis01filipe/olamundo-flask:${env.BUILD_NUMBER}'
                        bat 'docker push luis01filipe/olamundo-flask:latest'
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                        bat 'kubectl apply -f k8s-deployment.yaml --validate=false'
                    }
                }
            }
        }
    }
}
