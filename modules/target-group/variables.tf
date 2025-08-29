# modules/target-group/variables.tf
variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the target group will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

# Health Check Variables
variable "health_check_path" {
  description = "Path for health check requests"
  type        = string
  default     = "/"
}

variable "health_check_matcher" {
  description = "HTTP codes to match as healthy responses"
  type        = string
  default     = "200"
}

variable "health_check_port" {
  description = "Port for health checks (use traffic-port for container port)"
  type        = string
  default     = "traffic-port"
}

variable "health_check_interval" {
  description = "Time between health checks (seconds)"
  type        = number
  default     = 60
}

variable "health_check_timeout" {
  description = "Time to wait before considering the check failed (seconds)"
  type        = number
  default     = 30
}

variable "healthy_threshold" {
  description = "Number of successes before considering target healthy"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Number of failures before considering target unhealthy"
  type        = number
  default     = 5
}

