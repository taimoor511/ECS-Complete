# modules/acm/main.tf
output "certificate_domain" {
  description = "Domain name of the ACM certificate"
  value       = var.create_acm ? try(aws_acm_certificate.this[0].domain_name, null) : try(data.aws_acm_certificate.existing[0].domain, null)
}
output "certificate_validation_status" {
  description = "Validation status of the ACM certificate (null if using existing)"
  value       = var.create_acm ? try(aws_acm_certificate.this[0].status, null) : "EXISTING"
}
output "certificate_arn" {
  value = var.create_acm ? aws_acm_certificate.this[0].arn : data.aws_acm_certificate.existing[0].arn
}
