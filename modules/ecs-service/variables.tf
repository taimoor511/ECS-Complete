# modules/ecs-service/variables.tf:
variable "service_name" { type = string }
variable "cluster_id"   { type = string }
variable "cluster_name" { type = string }

# Change: pass the task definition ARN instead of family
variable "task_definition_arn" { type = string }

variable "desired_count" { type = number }
variable "min_count"     { type = number }
variable "max_count"     { type = number }

variable "container_name" { type = string }
variable "container_port" { type = number }

variable "private_subnets" { type = list(string) }
variable "ecs_service_sg_id" { type = string }

variable "target_group_arn" { type = string }

variable "scaling_policy_name" { type = string }
variable "scaling_metrics" {
  type        = list(string)
  default     = ["ECSServiceAverageCPUUtilization"]
}

variable "tags" {
  type    = map(string)
  default = {}
}
