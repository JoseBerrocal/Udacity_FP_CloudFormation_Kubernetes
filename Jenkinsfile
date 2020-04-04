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
                 echo 'Deploy Infraestructure'
                 sh "aws s3 ls"
                 echo 'Deploy Infraestructure successfully'
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
