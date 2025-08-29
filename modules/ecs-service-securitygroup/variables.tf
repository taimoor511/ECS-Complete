# modules/ecs-service-securitygroup/variable.tf:
variable "sg_name" {
  description = "Name of the ECS service security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ECS service SG will be created"
  type        = string
}

variable "alb_sg_id" {
  description = "Security group ID of the ALB"
  type        = string
}

variable "container_port" {
  description = "Container port for ECS service"
  type        = number
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
