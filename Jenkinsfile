
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
stage('Configure Docker PATH') {
    steps {
        script {
            env.PATH = "C:\\Users\\USER\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin;${env.PATH}"
        }
    }
}


       
stage('Check Docker') {
    steps {
        bat '"C:\\Users\\USER\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin\\docker.exe" --version'
    }
}

        stage('Start MySQL') {
            steps {
                bat 'docker compose up -d db'
            }
        }

        stage('Run Flyway Migrations') {
            steps {
                bat '''
                docker compose --profile migration run --rm flyway -url="jdbc:mysql://db:3306/student_db?allowPublicKeyRetrieval=true&sslMode=DISABLED" -user=migration_user -password=LocalMigrationPass123! -locations=filesystem:/flyway/sql migrate
                '''
            }
        }

        stage('Verify Migrations') {
            steps {
                bat '''
                docker compose --profile migration run --rm flyway -url="jdbc:mysql://db:3306/student_db?allowPublicKeyRetrieval=true&sslMode=DISABLED" -user=migration_user -password=LocalMigrationPass123! -locations=filesystem:/flyway/sql info
                '''
            }
        }
    }

    post {
        success {
            echo 'SUCCESS: Database migrations completed!'
        }
        failure {
            echo 'FAILED: Check Jenkins Console Output.'
        }
    }
}
