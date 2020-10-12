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
        stage('Deploy in Kube'){
            steps{
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
                sshagent(['Kubemaster']) {
                    sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml osboxes@192.168.1.200:/home/osboxes"
                    script{
                        try{
                            sh "ssh osboxes@192.168.1.200 kubectl apply -f ."
                        }catch(error){
                            sh "ssh osboxes@192.168.1.200 kubectl create -f ."
                        }
                    }
                }
            }
        }
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}