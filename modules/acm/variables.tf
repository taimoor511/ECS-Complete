# modules/acm/main.tf
variable "create_acm" {
  type    = bool
  default = false
}

variable "domain_name" {
  type        = string
  description = "The domain name for the ACM certificate"
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID for domain validation"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g., dev, staging, prod)"
  type        = string
}

variable "owner" {
  description = "Owner tag"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
