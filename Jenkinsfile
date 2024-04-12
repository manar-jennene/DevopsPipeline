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

<<<<<<< HEAD
      stage('Build Docker Image (Spring Part)') {
    steps {
        script {
            // Assurez-vous que cette commande est exécutée sur un agent où Jenkins a les droits Docker appropriés.
            def dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
=======
       stage('Build Docker Image (Spring Part)') {
            steps {
                script {
                    sh 'sudo chmod 666 /var/run/docker.sock'
                    def dockerImage=docker.build("manar23/timesheet-devops:1.0.0")
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerpwd')]) {
                        sh '''
                        docker login -u manar23 -p "manar23071"
                        docker push manar23/timesheet-devops:1.0.0
                        '''
                    }
                }
            }
>>>>>>> d4208edaabff970c1066b6ebb33715b35d079f2c
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
