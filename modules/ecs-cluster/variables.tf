# modules/ecs-cluster/variables.tf
variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
