#ROOT(terraform.tfvars)
#######################################
# DEFAULT
#######################################
# use this file if HOSTED ZONE is not on AWS
#######################################

# Toggle whether to create: task definition + ECS service  +ACM + HTTPS listner
# NOTE: If want_to_create_taskdef_and_service is set to false, then manually set both `is_hosted_zone_on_aws` and `create_acm` to false
want_to_create_taskdef_and_service = true
# is Hosted Zone on AWS
is_hosted_zone_on_aws=true
# Toggle whether to create: ACM + Route53 creation
create_acm = false

#######################################
# VPC CONFIGURATION
#######################################

# AWS region to deploy resources
region = "us-east-1"

# Name for the VPC
vpc_name = "project-vpc"

# VPC CIDR block (IP range)
vpc_cidr = "10.0.0.0/16"

# Availability Zones to use (make sure these exist in your region)
azs = ["us-east-1a", "us-east-1b"]

# Public subnets (used for load balancer, NAT gateway, etc.)
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

# Private subnets (used for ECS tasks/services)
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]


#######################################
# SECURITY GROUPS
#######################################

# Security group for the Application Load Balancer
sg_name = "project-alb-sg"

# Security group for ECS service tasks
ecs_service_sg_name = "project-ecs-service-sg"


#######################################
# LOAD BALANCER + TARGET GROUP
#######################################

# Name of Application Load Balancer (ALB)
alb_name = "project-alb"

# Name of Target Group for routing traffic to ECS service
target_group_name = "project-tg"
health_check_path     = "/health"
health_check_matcher  = "200"

#######################################
# ECS CLUSTER
#######################################

# ECS Cluster name
cluster_name = "project-cluster"

#######################################
# ECS TASK DEFINITION
#######################################

# Family name (identifier) for ECS task definition
task_family = "project-task"

# Task-level CPU and Memory (applies to the whole task)
# Must follow valid Fargate combinations (e.g. 512/1024/2048 CPU with 1–30 GB memory)
task_cpu    = "1024"   # 256 → 0.25 vCPU
task_memory = "2048"  # 512mb → 0.5 GB RAM

# Containers inside the ECS task
# Each container can define its own CPU, memory, ports, environment variables, dependencies, etc.
containers = [

  ###################################
  # Redis Container
  ###################################
  {
    name              = "redis"             # Container name
    image             = "redis:alpine"      # Docker image
    port              = 6379                # Exposed port
    cpu               = 256                 # CPU units (share of task CPU)
    gpu               = ""                  # Leave empty unless using GPU instances
    memory_hard_limit = 512                 # Max memory (container will be killed if exceeded)
    memory_soft_limit = 256                 # Reserved memory (guaranteed)
    essential         = true                # Task fails if this container fails
    environment       = []                  # No custom env vars
    dependencies      = []                  # No startup dependencies
    health_check = {                        # ECS health check
      command     = ["CMD-SHELL", "redis-cli ping | grep PONG"]
      interval    = 30
      retries     = 3
      startPeriod = 10
      timeout     = 5
    }
  },

  ###################################
  # MongoDB Container
  ###################################
  {
    name              = "mongo"
    image             = "mongo:latest"
    port              = 27017
    cpu               = 256
    gpu               = ""
    memory_hard_limit = 512
    memory_soft_limit = 256
    essential         = true
    environment       = [                   # MongoDB requires root credentials
      { name = "MONGO_INITDB_ROOT_USERNAME", value = "root" },
      { name = "MONGO_INITDB_ROOT_PASSWORD", value = "example" }
    ]
    dependencies      = []
    health_check = {
      command     = ["CMD-SHELL", "mongosh --username root --password example --eval \"db.adminCommand('ping')\" || exit 1"]
      interval    = 30
      retries     = 3
      startPeriod = 20
      timeout     = 5
    }
  },

  ###################################
  # Application Container
  ###################################
  {
    name              = "project-app"
    image             = "084828600005.dkr.ecr.us-east-1.amazonaws.com/taimoor/project:latest" # Replace with your ECR image
    port              = 5000
    cpu               = 256
    gpu               = ""
    memory_hard_limit = 512
    memory_soft_limit = 256
    essential         = true
    environment = [                               # Application environment variables
      { name = "PORT", value = "5000" },
      { name = "MONGODB_URI", value = "mongodb://root:example@127.0.0.1:27017/taimoor?authSource=admin" },
      { name = "REDIS_URL", value = "redis://127.0.0.1:6379" }
    ]
    dependencies = [                              # Start app only after DB + Cache are healthy
      { containerName = "redis", condition = "HEALTHY" },
      { containerName = "mongo", condition = "HEALTHY" }
    ]
    # Optional: Add health check for your app (uncomment and modify if needed)
    health_check = null
  }
]

#######################################
# ECS SERVICE CONFIGURATION
#######################################

# Name of the ECS Service
ecs_service_name = "project-service"

# Desired number of running tasks (can scale between min and max)
desired_count = 1
min_count     = 1
max_count     = 2

# Auto-scaling policy
scaling_policy_name = "project-scaling-policy"

# Choose scaling metric: "ECSServiceAverageCPUUtilization" or "ECSServiceAverageMemoryUtilization"
scaling_metrics = ["ECSServiceAverageCPUUtilization", "ECSServiceAverageMemoryUtilization"]
# Container that should be attached to the ALB (your app container)
load_balanced_container_name = "project-app"
load_balanced_container_port = 5000

#######################################
# ACM CERTIFICATE
#######################################

# Your domain (must already exist in Route53)
domain_name   = "*.taimoor.site"
# Hosted zone ID for the domain in Route53
hosted_zone_id = "Z0700718GCRWXN5WH2MS"

#######################################
# HTTPS LISTNER
#######################################

https_domain          = "backend.taimoor.site"

#######################################
# TAGGING (for cost allocation & ownership)
#######################################

environment = "development"   # e.g. dev / staging / prod
owner       = "devops-team"   # Who owns this infra
