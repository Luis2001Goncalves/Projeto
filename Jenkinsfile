pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // Credenciais do Docker
        DOCKER_IMAGE = 'luis01filipe/olamundo-flask' // Nome da imagem Docker
        KUBE_CONFIG_PATH = 'C:\\Users\\user\\.kube\\config' // Caminho do kubeconfig no Windows
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Luis2001Goncalves/Projeto.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    bat 'docker build -t luis01filipe/olamundo-flask:latest .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS_ID) {
                        bat 'docker push luis01filipe/olamundo-flask:latest'
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    bat 'kubectl apply -f k8s-deployment.yaml'
                }
            }
        }
    }
}
