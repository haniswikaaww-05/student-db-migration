
pipeline {
    agent any

    environment {
        COMPOSE = 'C:\\Users\\USER\\AppData\\Local\\Programs\\DockerDesktop\\resources\\cli-plugins\\docker-compose.exe'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Check Docker') {
            steps {
                bat '"C:\\Users\\USER\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin\\docker.exe" --version'
                bat '"%COMPOSE%" version'
            }
        }

        stage('Start MySQL') {
            steps {
                bat '"%COMPOSE%" up -d db'
            }
        }

        stage('Run Flyway Migrations') {
            steps {
                bat '''
                "%COMPOSE%" --profile migration run --rm flyway -url="jdbc:mysql://db:3306/student_db?allowPublicKeyRetrieval=true&sslMode=DISABLED" -user=migration_user -password=LocalMigrationPass123! -locations=filesystem:/flyway/sql migrate
                '''
            }
        }

        stage('Verify Migrations') {
            steps {
                bat '''
                "%COMPOSE%" --profile migration run --rm flyway -url="jdbc:mysql://db:3306/student_db?allowPublicKeyRetrieval=true&sslMode=DISABLED" -user=migration_user -password=LocalMigrationPass123! -locations=filesystem:/flyway/sql info
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
