pipeline {
    agent any
    
    environment {
        GIT_REPO = "https://github.com/marbar35/hexlet-git.git"
        GIT_BRANCH = "main"
        DOCKER_IMAGE = "world"
        DOCKER_REGISTRY = "http://127.0.0.1:8085/repository/jenkins-repo/"
        NEXUS_CREDENTIALS = "nexus"
        imageFullName = "hello"
        
        
    }
    
    stages {
        stage('Checkout') {
            steps {
                // клонируем репозиторий из GitHub
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }
        stage('Build Docker Image') {
            steps {
                // собираем Docker-образ из исходников
                script {
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }
        stage('Push Docker Image to Nexus') {
            steps {
                    script {
                    docker.withRegistry("${DOCKER_REGISTRY}", "${NEXUS_CREDENTIALS}") {
                    def customImage = docker.image("${DOCKER_IMAGE}")
                            customImage.tag "${imageFullName}"
                            customImage.push()
                    }
                }
            }
        }
    }
}
