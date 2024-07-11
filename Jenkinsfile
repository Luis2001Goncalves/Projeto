pipeline {
    agent any
    environment {
        KUBE_CONFIG_PATH = 'C:\\Users\\user\\.kube\\config'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Luis2001Goncalves/Projeto.git', branch: 'main'
            }
        }
        stage('Install Dependencies') {
            steps {
                bat 'pip install -r requirements.txt'
            }
        }
        stage('Lint') {
            steps {
                bat 'flake8 app.py'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("luis01filipe/olamundo-flask")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-credentials') {
                        docker.image("luis01filipe/olamundo-flask").push("${env.BUILD_NUMBER}")
                        docker.image("luis01filipe/olamundo-flask").push("latest")
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
