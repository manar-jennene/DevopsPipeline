pipeline {
    agent any 
    stages {
        stage('Checkout GIT') {
            steps {
                echo 'Pulling...'
                git branch: 'chadha',
                url: 'https://github.com/manar-jennene/DevopsPipeline.git'
            }
        }

        stage('Testing maven') {
            steps {
                sh 'mvn -version'
            }
        }

        stage('SONARQUBE') {
            steps {
                sh "mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar"
            }
        }
    }
}
