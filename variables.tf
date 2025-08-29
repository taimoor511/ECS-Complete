#ROOT(variables.tf)
# VPC
variable "region" { type = string }
variable "vpc_name" { type = string }
variable "vpc_cidr" { type = string }
variable "azs" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }

# ALB SG
variable "sg_name" { type = string }

# Target Group
variable "target_group_name" { type = string }

variable "health_check_path" {
  type        = string
  default     = "/"
}
variable "health_check_matcher" {
  type        = string
  default     = "200"
}
variable "health_check_port" {
  type        = string
  default     = "traffic-port"
}
variable "health_check_interval" {
  type        = number
  default     = 30
}
variable "health_check_timeout" {
  type        = number
  default     = 5
}
variable "healthy_threshold" {
  type        = number
  default     = 5
}
variable "unhealthy_threshold" {
  type        = number
  default     = 3
}
# ALB
variable "alb_name" { type = string }

# ECS Cluster
variable "cluster_name" { type = string }

# whether you want to create taskdefination and service or not
variable "want_to_create_taskdef_and_service" {
  type    = bool
  default = true
}

# ECS Task Definition
variable "task_family" { type = string }
variable "task_cpu"    { type = string }
variable "task_memory" { type = string }

variable "containers" {
  description = <<EOT
List of container definitions.
Each object should have:
  - name
  - image
  - port
  - cpu
  - gpu
  - memory_hard_limit
  - memory_soft_limit
  - essential
  - environment (list of { name, value })
  - dependencies (list of { containerName, condition })
EOT
  type = list(object({
    name               = string
    image              = string
    port               = number
    cpu                = number
    gpu                = string
    memory_hard_limit  = number
    memory_soft_limit  = number
    essential          = bool
    environment        = list(object({ name = string, value = string }))
    dependencies       = list(object({ containerName = string, condition = string }))
    health_check       = optional(object({
      command     = list(string)
      interval    = number
      retries     = number
      startPeriod = number
      timeout     = number
    }), null)
  }))
}

# ECS Service SG
variable "ecs_service_sg_name" { type = string }

# ECS Service
variable "ecs_service_name" { type = string }
variable "desired_count"    { type = number }
variable "min_count"        { type = number }
variable "max_count"        { type = number }
variable "scaling_policy_name" { type = string }
variable "scaling_metrics" {
  type        = list(string)
  default     = ["ECSServiceAverageCPUUtilization"]
}


# Which container is behind ALB
variable "load_balanced_container_name" { type = string }
variable "load_balanced_container_port" { type = number }

# Env + Tags
variable "environment" { type = string }
variable "owner"       { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}
# ACM Certificate
variable "create_acm" {
  type        = bool
  default     = true
}
variable "domain_name" { type = string }
variable "hosted_zone_id" { type = string}
# HTTPS Listner

variable "https_domain" {
  description = "Domain name to use in HTTPS listener Host Header and Route53 record"
  type        = string
  default     = "backend.taimoor.site"
}

variable "is_hosted_zone_on_aws" {
  type    = bool
  default = false
}
