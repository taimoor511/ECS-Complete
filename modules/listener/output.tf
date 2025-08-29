# modules/listener/output.tf
output "https_listener_arn" {
  value = try(aws_lb_listener.https.arn, null)
}

output "https_listener_rule_arn" {
  value = try(aws_lb_listener_rule.https_host_header.arn, null)
}

output "https_record_fqdn" {
  value = try(aws_route53_record.https_record.fqdn, null)
}

