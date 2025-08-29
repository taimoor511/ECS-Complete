# modules/listener/variables.tf

variable "alb_arn" {
  description = "ARN of the ALB to attach the HTTPS listener"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group to forward requests"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS listener"
  type        = string
}

variable "https_domain" {
  description = "Domain name to use in HTTPS listener Host Header and Route53 record"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID for creating the DNS record"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB, used for Route53 record"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB hosted zone ID, used for Route53 record"
  type        = string
}
