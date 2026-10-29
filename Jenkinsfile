
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Check Docker') {
            steps {
                bat 'docker --version'
                bat 'docker compose version'
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
