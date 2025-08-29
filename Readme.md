### aws configure
### cat ~/.aws/credentials
### aws configure --profile=
### export AWS_PROFILE=

===================================
### terraform init
### terraform validate
### terraform plan
### terraform apply
### terraform state list
### terraform destroy -auto-approve

==================================
#  Terraform AWS ECS Fargate Infrastructure

This repository contains a fully modular Terraform setup for deploying a containerized application on AWS ECS Fargate, fronted by an Application Load Balancer (ALB), with secure networking, auto-scaling, and logging.

The infrastructure is broken down into reusable Terraform modules that can be easily customized and extended for production workloads.

#  🚀 Features

# VPC Module

- Creates a VPC with public and private subnets, NAT Gateway, and routing.

# ALB & Target Group

- Application Load Balancer with listeners and a target group.

- Health checks configured for containerized apps.

# Security Groups

- ALB Security Group (HTTP/HTTPS).

- ECS Service Security Group (restricted to ALB).

# ECS Cluster (Fargate)

- Serverless ECS cluster using Fargate capacity provider.

# ECS Task Definition

- Configurable CPU, memory, ports, and container image.

- Integrated with CloudWatch Logs.

# ECS Service

- Deploys containers into the ECS cluster with ALB integration.

- Auto-scaling based on CPU/Memory utilization.

# Outputs

- Provides IDs, ARNs, and DNS names for easy integration.