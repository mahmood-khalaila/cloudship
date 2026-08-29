pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mahmoodkhalaila/cloudship'
    }

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

        stage('Docker Build') {
            steps {
                sh '''
                    docker build \
                      -t ${DOCKER_IMAGE}:${BUILD_NUMBER} \
                      -t ${DOCKER_IMAGE}:latest \
                      .
                '''
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKERHUB_USERNAME',
                        passwordVariable: 'DOCKERHUB_TOKEN'
                    )
                ]) {
                    sh '''
                        echo "${DOCKERHUB_TOKEN}" |
                          docker login \
                            --username "${DOCKERHUB_USERNAME}" \
                            --password-stdin

                        docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}
                        docker push ${DOCKER_IMAGE}:latest
                        docker logout
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'CloudShip CI and Docker push completed successfully!'
        }

        failure {
            echo 'CloudShip pipeline failed. Check the stage logs.'
        }

        always {
            deleteDir()
        }
    }
}