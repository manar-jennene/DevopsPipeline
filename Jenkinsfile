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
            // Installer le plugin Prometheus Metrics dans Jenkins
            // Redémarrer Jenkins si nécessaire

            // Créer un conteneur Docker Prometheus
            sh 'sudo chmod 666 /var/run/docker.sock'
            sh 'docker run -d --name prometheus -p 9090:9090 prom/prometheus'

            // Configurer Prometheus pour surveiller Jenkins
            sh '''
            docker exec -it prometheus sh -c "tee -a /etc/prometheus/prometheus.yml <<EOF
            - job_name: jenkins
              metrics_path: /prometheus
              static_configs:
              - targets: ['172.17.0.1:8080']'''

            // Redémarrer le conteneur Prometheus
            sh 'docker restart prometheus'

            // Créer un conteneur Docker Grafana
            sh 'docker run -d --name grafana -p 3000:3000 grafana/grafana'
        }
    }
}


    }
}
