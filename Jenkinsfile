pipeline {
    agent any
    
    environment {
        // Set your Docker image and tag here
        IMAGE_NAME = 'shubh21/jenkins-kubernetes-deploymentloyment'
        IMAGE_TAG = 'v1.0.0'
        DOCKER_REGISTRY = 'docker.io'  // Change if using a different registry
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Jenkins credential ID for Docker login
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Checkout the Git repository
                git 'https://github.com/shubh21/jenkins-kubernetes-deploymentloyment.git'
            }
        }

        stage('Build with Maven') {
            steps {
                script {
                    // Clean and build the Java app with Maven
                    sh 'mvn clean package'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run unit tests with Maven
                    sh 'mvn test'
                }
            }
        }

        stage('Docker Build and Push') {
            steps {
                script {
                    // Log in to Docker Hub using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }

                    // Build the Docker image
                    sh "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ."

                    // Push the Docker image to Docker Hub
                    sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                // You can add deployment steps here, such as:
                // - Kubernetes deployment using kubectl
                // - Docker Swarm or ECS deployment
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
