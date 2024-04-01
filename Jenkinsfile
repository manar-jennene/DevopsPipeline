pipeline {
  agent any 
  stages{
    stage('Checkout GIT'){
      steps {
        echo 'Pulling...';
        git branch: 'chadha',
          url: 'https://github.com/manar-jennene/DevopsPipeline.git';
      }
    }

    
    stage('Testing maven'){
      steps {
        sh """mvn -version"""
      }
    }

    stage('SonarQube Analysis') {
    steps {
        script {
            def scannerHome = tool 'scanner'
            withSonarQubeEnv {
                sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=ChadhaTWIN8"
            }
        }
    }
}

    
  }
}
