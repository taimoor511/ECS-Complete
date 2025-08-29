# modules/alb/variables.tf

variable "alb_name" {type = string}

variable "alb_sg_id" {type = string}

variable "public_subnets" { type = list(string) }

variable "target_group_arn" { type = string }

variable "tags" {
  type        = map(string)
  default     = {}
}
