pipeline {

  environment {
    repodocker = "joseberrocal/udacity_fp_cloudformation_kubernetes"
    registryCredential = 'docker-hub'
    dockerImage = ''
  }
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
       /*       echo 'Create a  VPC for the EKS'
                sh "aws s3 ls"
                sh "./infraestructure/create.sh InfraFinalProject infraestructure/ourinfra.yml infraestructure/ourinfra-params.json"
                sh "sleep 100"
                echo 'VPC for the EKS deployed successfully'
                echo 'Create a EKS Cluster'
                sh "./infraestructure/create.sh EKS-Cluster infraestructure/eks_cluster.yml infraestructure/eks_cluster-params.json"
                sh "sleep 900"
                echo 'EKS cluster deployed successfully'               
                echo 'Create a EKS Nodes'
                sh "./infraestructure/create.sh EKS-Nodes infraestructure/eks_nodegroup.yml infraestructure/eks_nodegroup-params.json"
                sh "sleep 240"
                echo 'EKS nodes deployed successfully'      */ 
                sh "kubectl config use-context arn:aws:eks:us-west-2:545867861938:cluster/ClusterEKS-FP"
                sh "aws eks --region us-west-2 update-kubeconfig --name ClusterEKS-FP"
                sh "sleep 5"
                sh "kubectl get svc"
                sh "sleep 5"       
                sh "sh infraestructure/IAM_node.sh" 
                sh "cat infraestructure/aws-auth-cm.yaml"
                sh "sleep 5"
                sh "kubectl apply -f infraestructure/aws-auth-cm.yaml"
                sh "kubectl get nodes"
                sh "sleep 5"      
                sh "kubectl get nodes"
                sh "sleep 5"     
                sh "kubectl get nodes"                                          
            }
        }

       stage('Build Docker Image') {

             steps {
                 checkout scm
                echo 'Build Docker Image'
                script {
                    dockerImage = docker.build repodocker + ":$BUILD_NUMBER"
                    }
                 echo 'Creation of Docker Image successfully'
                 }
             }


       stage('Upload the docker image') {
             steps {
                echo 'Upload of Docker'
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push('latest')
                        }
                    }
                 echo 'Upload of Docker sucessfully'
                 }
             }



       stage('Deploy the application using kubernetes') {
             steps {
                 echo 'Deploy the application using kubernetes'
                 echo 'Creating the deployment'
                 sh "kubectl create -f deployment_helloworld.yaml"
                 echo 'Exposing the http service'
                 sh "kubectl expose deployment hello-world --type=LoadBalancer --name=hello-world-svc-http"
                 sh "sleep 15"
                 sh "kubectl get pods"
                 sh "kubectl get deployment"
                 sh "kubectl get svc"
                 sh "sh ext_ip_svc.sh"
                 echo 'Deploy the application using kubernetes sucessfully'
                 }
             }

       stage('Remove Unused docker image') {
             steps {
                echo 'Remove Unused docker image'
                sh "docker rmi $repodocker:$BUILD_NUMBER"
                sh "docker rmi $repodocker:latest"
                 echo 'Remove Unused docker image sucessfully'
                 }
             }

    }
}
