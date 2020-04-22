[![CircleCI](https://circleci.com/gh/JoseBerrocal/Udacity_FP_CloudFormation_Kubernetes.svg?style=svg)](https://circleci.com/gh/JoseBerrocal/Udacity_FP_CloudFormation_Kubernetes)

# Udacity Cloud DevOps Final Project

## Project Overview

In this project will be develop a CI/CD pipeline for a Hello World application with rolling deployment. Continuous Integration steps will be added, also typographical checking (aka “linting”). 

This project include the following technologies:
- CloudFormation
- Jenkins
- Rolling Deployment
- Docker
- Kubernetes

## Project Tasks

The project goal is to operationalize the Hello World app using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:
* Configure Kubernetes, Docker, Hadolint, Circleci
* Test your project code using linting
* Complete a Dockerfile to containerize this application
* Use cloudformation to configure the VPC infraestucture, create a kubernetes cluster and create kubernetes nodes
* Deploy a container using Kubernetes and access the app by web
* Upload a complete Github repo with CircleCI to indicate that your code has been tested

---

## Setup the Environment

It is necesarry to have configured a jenkis server, with the plugins that will allow the use of cloudformation, kubenetes and docker. Aditionally pylint must be installed

---

### Complete Deployment

The most importan branches in this repository are **master** and **deploy_app** 

To Deploy the app for the firts time you must execute the branch **master**

When **master** branch is executed the following stages of Jenkinsfile will be executed:
- Test the Jenkinsfile
- Test the Files
- Deploy Infraestructure
- Build Docker Image
- Upload the Docker Image
- Deploy the Application
- Remove Unused Docker Image

![alt text](https://github.com/JoseBerrocal/Udacity_FP_CloudFormation_Kubernetes/blob/improve_text_file/images/Complete_deployment.png "Complete Deployment")

Here is a reference how to manually execute the stage "Deploy Infraestructure":
[Deploying a Kubernetes Cluster with Amazon EKS](https://logz.io/blog/amazon-eks-cluster/)

### Application Update

To Update the app "hello.py" you must execute the branch **deploy_app**

When **deploy_app** branch is executed the following stages of Jenkinsfile will be executed:
- Test the Jenkinsfile
- Test the Files
- Build Docker Image
- Upload the Docker Image
- Application Update
- Remove Unused Docker Image

![alt text](https://github.com/JoseBerrocal/Udacity_FP_CloudFormation_Kubernetes/blob/improve_text_file/images/Udpate_Hello_app.png "Application Update")

Check the "Application Update" stage to observe the Rolling Deployment

![alt text](https://github.com/JoseBerrocal/Udacity_FP_CloudFormation_Kubernetes/blob/improve_text_file/images/Rolling_Update.png "Rolling Deployment")

In case the sintax of the app update is incorrect the following output will be shown

![alt text](https://github.com/JoseBerrocal/Udacity_FP_CloudFormation_Kubernetes/blob/improve_text_file/images/Fail_Lint_Top.png "Fail Lint Check")