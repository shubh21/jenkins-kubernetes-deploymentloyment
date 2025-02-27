pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'  // Use 'gradle build' if using Gradle
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'  // Run unit tests (or 'gradle test')
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
            }
        }
    }
}

