pipeline {
    agent any

    environment {
 DOCKER_IMAGE = 'manar23/timesheet-devops'
        DOCKER_TAG = '1.0.0'
    }

    stages {
        stage('Git') {
            steps {
                echo "Pulling"
                git branch: 'manar', url: 'https://github.com/manar-jennene/DevopsPipeline.git'
            }
        }

        stage('Maven Build') {
            steps {
                sh "mvn clean compile"
            }
        }

        stage('SONARQUBE') {
            steps {
                sh "mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar"
            }
        }

        stage('Nexus') {
            steps {
                script {
                    sh 'mvn deploy -DskipTests'
                }
            }
        }

         // Ajout de la construction de l'image Docker
               stage('Build Docker Image') {
                   steps {
                       script {
                           sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                       }
                   }
               }

        // Ajout du dépôt de l'image Docker sur DockerHub
        stage('Push to DockerHub') {
            steps {
                script {
                    sh "docker login -u manar23 -p manar23071"
                    sh "docker push manar23/timesheet-devops:1.0.0"

                }
            }
        }

        stage('Monitoring with Prometheus and Grafana') {
            steps {
                echo "Checking Prometheus metrics"
                sh "curl http://172.21.212.225:9090/api/v1/query?query=instance_cpu_usage"

                echo "Updating Grafana Dashboard"
                sh "curl -X POST http://172.21.212.225:3000/api/dashboards/db"
            }
        }
    }
}
