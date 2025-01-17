pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        DOCKER_IMAGE = 'luis01filipe/olamundo-flask'
        KUBE_CONFIG_PATH = 'C:\\Users\\user\\.kube\\config'
        PATH = "C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python312;C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python312\\Scripts;${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Luis2001Goncalves/Projeto.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                bat '''
                pip install -r requirements.txt
                '''
            }
        }
        stage('Lint') {
            steps {
                bat '''
                flake8 app.py
                '''
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage('Test Kubernetes Connectivity') {
            steps {
                script {
                    bat "kubectl get nodes --kubeconfig=${KUBE_CONFIG_PATH}"
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    bat "kubectl apply --validate=false -f k8s-deployment.yaml --kubeconfig=${KUBE_CONFIG_PATH}"
                }
            }
        }
    }
}
