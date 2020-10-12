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
                    sh "ssh osboxes@kubemaster ls -ltr /tmp"
                    //sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml osboxes@kubemaster:/home/osboxes"
                    //script{
                      //  try{
                        //    sh "ssh osboxes@kubemaster kubectl apply -f ."
                        //}catch(error){
                          //  sh "ssh osboxes@kubemaster kubectl create -f ."
                        //}
                    //}
                }
            }
        }
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}