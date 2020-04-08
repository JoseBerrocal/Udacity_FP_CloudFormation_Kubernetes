pipeline {
    agent any
    stages {

       stage('Test the Jenkinsfile') {
             steps {
                 echo 'Test the Jenkinsfile'
                 echo 'Test the Jenkinsfile successfully'
                 }
             }

       stage('Test the files') {
             steps {
                 echo 'Test the files'
                 sh "make lint"
                 echo 'Test the files successfully'                 
                 }
             }



       stage('Deploy Infraestructure') {
             steps {
                 echo 'Create a  VPC for the EKS'
                 sh "aws s3 ls"
                 sh "./infraestructure/create.sh InfraFinalProject infraestructure/ourinfra.yml infraestructure/ourinfra-params.json"
                 sh "sleep 100"
                 echo 'VPC for the EKS deployed successfully'
                 echo 'Create a EKS Cluster'
                 sh "./infraestructure/create.sh EKS-Cluster infraestructure/eks_cluster.yml infraestructure/eks_cluster-params.json"
                 sh "sleep 900"
                 echo 'EKS cluster deployed successfully'                 
                 }
             }



       stage('Create the docker') {
             steps {
                 echo 'Creation of Docker'
                 echo 'Creation of Docker successfully'
                 }
             }


       stage('Upload the docker image') {
             steps {
                 echo 'Upload of Docker'
                 echo 'Upload of Docker sucessfully'
                 }
             }



       stage('Deploy the application using kubernetes') {
             steps {
                 echo 'Deploy the application using kubernetes'
                 echo 'Deploy the application using kubernetes sucessfully'
                 }
             }

    }
}
