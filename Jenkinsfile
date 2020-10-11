pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    stages{
        stage('Build Mvn and Docker Image'){
            steps{
                sh "mvn clean package"
                sh "docker build . -t guruprasanna30/newbuild:${DOCKER_TAG}"
            }
        }
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}