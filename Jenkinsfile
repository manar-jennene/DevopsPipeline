pipeline {
    agent any 
    environment {
 DOCKER_IMAGE = 'chadhahannachi/achat'
        DOCKER_TAG = '1.0.0'
    }
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

        stage('SonarQube') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar -Dsonar.exclusions=**/*.java'
            }
        }

        stage('Nexus') {
            steps {
                script {
                sh 'mvn deploy -DskipTests'
                    }
            }
        }


       stage('Build Docker Image (Spring Part)') {
            steps {
                script {
                    sh 'sudo chmod 666 /var/run/docker.sock'
                    def dockerImage=docker.build("chadhahannachi/achat:1.0.0")
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerpwd')]) {
                        sh '''
                        docker login -u chadhahannachi -p "chadha123"
                        docker push chadhahannachi/achat:1.0.0
                        '''
                    }
                }
            }
        }
 

    }
}
