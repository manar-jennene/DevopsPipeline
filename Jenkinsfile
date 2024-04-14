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

        stage('maven build') {
            steps {
                sh 'mvn clean compile'
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


        stage('Build Docker Image') {
            steps {
                script {
                    // sh 'sudo chmod 666 /var/run/docker.sock'
                    def dockerImage=docker.build("chadhahannachi/achat:1.0.0")
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhubpwd', usernameVariable: 'chadhahannachi', passwordVariable: 'chadha123')]) {
                        sh '''
                        docker login -u chadhahannachi -p "chadha123"
                        docker push chadhahannachi/achat:1.0.0
                        '''
                    }
                }
            }
        }

        stage('Run Docker Compose') {
    steps {
        script {
            sh 'docker-compose up -d'
        }
    }
}

        stage('Setup Monitoring') {
    steps {
        script {
            
            sh 'docker start prometheus'
            sh 'docker start grafana'

        }
    }
}


    }
}
