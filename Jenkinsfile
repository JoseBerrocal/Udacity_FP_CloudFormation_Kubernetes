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

       stage('Test the Files') {
             steps {
                 echo 'Test the Files'
                 sh "make lint"
                 echo 'Test the Files successfully'                 
                 }
             }



       stage('Deploy Infraestructure') {
           when {
               branch 'master'
           }
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
                echo 'Create a EKS Nodes'
                sh "./infraestructure/create.sh EKS-Nodes infraestructure/eks_nodegroup.yml infraestructure/eks_nodegroup-params.json"
                sh "sleep 240"
                echo 'EKS nodes deployed successfully'
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


       stage('Upload the Docker Image') {
             steps {
                echo 'Upload of Docker'
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                        dockerImage.push('latest')
                        }
                    }
                 echo 'Upload of Docker Image sucessfully'
                 }
             }



       stage('Deploy the Application') {
           when {
               branch 'master'
           }           
             steps {
                 echo 'Deploy the Application'
                 echo 'Creating the deployment'
                 sh "aws eks --region us-west-2 update-kubeconfig --name ClusterEKS-FP"
                 sh "sleep 5"
                 sh "kubectl create -f deployment_helloworld.yaml"
                 echo 'Exposing the http service'
                 sh "kubectl expose deployment hello-world --type=LoadBalancer --name=hello-world-svc-http"
                 sh "sleep 15"
                 sh "kubectl get pods"
                 sh "kubectl get deployment"
                 sh "kubectl get svc"
                 sh "sh ext_ip_svc.sh"
                 echo 'Deploy the Application sucessfully'
                 }
             }


       stage('Application Update') {
           when {
               branch 'deploy_app'
           }           
             steps {
                 echo 'Application Update'
                 echo 'Updating the deployment'
                 sh "aws eks --region us-west-2 update-kubeconfig --name ClusterEKS-FP"
                 sh "sleep 5"
                 sh "kubectl get pods"
                 sh "sed -i 's|latest|${BUILD_NUMBER}|g' deployment_helloworld.yaml"
                 sh "kubectl apply -f deployment_helloworld.yaml"
                 sh "sleep 7"
                 sh "kubectl get pods"
                 sh "sleep 20"
                 sh "kubectl get pods"                
                 sh "sh ext_ip_svc.sh"
                 echo 'Application Update sucessfully'
                 }
             }


       stage('Remove Unused Docker Image') {
             steps {
                echo 'Remove Unused Docker Image'
                sh "docker rmi $repodocker:$BUILD_NUMBER"
                sh "docker rmi $repodocker:latest"
                 echo 'Remove Unused Docker Image sucessfully'
                 }
             }

    }
}
