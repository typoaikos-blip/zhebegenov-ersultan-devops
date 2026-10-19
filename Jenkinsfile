pipeline {
    agent any

    environment {
        STUDENT_NAME    = 'Ersultan'
        STUDENT_SURNAME = 'Zhebegenov'
        STUDENT_GROUP   = 'IT2-2309'
        STUDENT_ID      = '37138'
        IMAGE_NAME      = 'zhebegenov-ersultan-devops'
        CONTAINER_NAME  = 'zhebegenov-ersultan-container'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh '''
                    echo "Repository: $(git config --get remote.origin.url)"
                    echo "Branch:     ${GIT_BRANCH}"
                    echo "Commit:     ${GIT_COMMIT}"
                    git log -1 --oneline
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                    echo "Student: ${STUDENT_NAME} ${STUDENT_SURNAME}"
                    echo "Group: ${STUDENT_GROUP}"
                    echo "Student ID: ${STUDENT_ID}"
                    chmod +x scripts/Zhebegenov_Ersultan_system.sh
                    ./scripts/Zhebegenov_Ersultan_system.sh
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    for f in Dockerfile docker-compose.yml Zhebegenov_Ersultan_info.txt \
                             app/app.py config/app.conf scripts/Zhebegenov_Ersultan_system.sh; do
                        test -f "$f" && echo "OK: $f exists" || { echo "MISSING: $f"; exit 1; }
                    done
                    bash -n scripts/Zhebegenov_Ersultan_system.sh && echo "OK: bash syntax"
                    grep -q "Student ID: ${STUDENT_ID}" Zhebegenov_Ersultan_info.txt && echo "OK: Student ID found"
                    echo "All tests passed"
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    docker build -t ${IMAGE_NAME}:latest -t ${IMAGE_NAME}:${BUILD_NUMBER} .
                    docker images ${IMAGE_NAME}
                '''
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
                    docker run -d \
                        -e STUDENT_NAME=${STUDENT_NAME} \
                        -e STUDENT_SURNAME=${STUDENT_SURNAME} \
                        -e STUDENT_GROUP=${STUDENT_GROUP} \
                        -e STUDENT_ID=${STUDENT_ID} \
                        -p 8001:8000 \
                        --name ${CONTAINER_NAME} \
                        ${IMAGE_NAME}:latest
                    sleep 3
                    docker ps --filter name=${CONTAINER_NAME}
                    docker logs ${CONTAINER_NAME}
                    docker exec ${CONTAINER_NAME} python -c "import urllib.request; print(urllib.request.urlopen('http://localhost:8000').read().decode())"
                '''
            }
        }
    }

    post {
        success { echo "Pipeline for ${STUDENT_SURNAME} ${STUDENT_NAME} finished successfully" }
        failure { echo 'Pipeline failed - check the stage marked in red' }
    }
}
