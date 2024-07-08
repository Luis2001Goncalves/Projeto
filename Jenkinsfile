pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // Substitua pelo ID das suas credenciais Docker
        DOCKER_IMAGE = 'luis01filipe/olamundo-flask' // Substitua pelo seu usuário/nome da imagem Docker
        KUBE_CONFIG_PATH = 'C:/Programas/Jenkins/.kube/config' // Substitua pelo caminho real do seu kubeconfig
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Luis2001Goncalves/Projeto.git' // Substitua pelo URL do seu repositório Git
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
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    kubernetesDeploy(configs: 'k8s-deployment.yaml', kubeConfig: [path: "${KUBE_CONFIG_PATH}"])
                }
            }
        }
    }
}
