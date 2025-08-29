# modules/acm/main.tf
#########################################
# ACM Certificate (conditionally created)
#########################################
# Create ACM certificate (only if create_acm = true)
resource "aws_acm_certificate" "this" {
  count  = var.create_acm ? 1 : 0
  domain_name       = var.domain_name
  validation_method = "DNS"

  # Only apply prevent_destroy when we are NOT creating
  lifecycle {
    prevent_destroy = false
  }
}
#########################################
# DNS validation record (only if creating cert)
#########################################
resource "aws_route53_record" "validation" {
  count = var.create_acm ? length(tolist(aws_acm_certificate.this[0].domain_validation_options)) : 0

  zone_id = var.hosted_zone_id
  name    = tolist(aws_acm_certificate.this[0].domain_validation_options)[count.index].resource_record_name
  type    = tolist(aws_acm_certificate.this[0].domain_validation_options)[count.index].resource_record_type
  records = [tolist(aws_acm_certificate.this[0].domain_validation_options)[count.index].resource_record_value]
  ttl     = 60
}

#########################################
# Certificate validation (only if creating cert)
#########################################
resource "aws_acm_certificate_validation" "this" {
  count = var.create_acm ? 1 : 0

  certificate_arn         = aws_acm_certificate.this[0].arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}

#########################################
# Lookup existing ACM cert (only if create_acm = false)
#########################################
data "aws_acm_certificate" "existing" {
  count  = var.create_acm ? 0 : 1
  domain   = var.domain_name
  statuses = ["ISSUED"]

  # When using data sources, nothing is destroyed anyway
}
