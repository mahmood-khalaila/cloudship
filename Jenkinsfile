pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                dir('app') {
                    sh '''
                        python3 -m venv .venv
                        .venv/bin/pip install --upgrade pip
                        .venv/bin/pip install -r requirements-dev.txt
                    '''
                }
            }
        }

        stage('Lint') {
            steps {
                dir('app') {
                    sh '.venv/bin/flake8 main.py tests/'
                }
            }
        }

        stage('Test') {
            steps {
                dir('app') {
                    sh '.venv/bin/python -m pytest -v'
                }
            }
        }
    }

    post {
        success {
            echo 'CloudShip CI passed successfully!'
        }

        failure {
            echo 'CloudShip CI failed. Check the stage logs.'
        }

        always {
            deleteDir()
        }
    }
}