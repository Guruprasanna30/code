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
        stage('Docker Push'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerhubpwd')]) {
                sh "docker login -u guruprasanna30  -p ${dockerhubpwd}"
                sh "docker push guruprasanna30/newbuild:${DOCKER_TAG}"
                }
            }
        }
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}