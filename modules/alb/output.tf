# modules/alb/output.tf
output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "alb_listener_arn" {
  description = "ARN of the ALB listener"
  value       = aws_lb_listener.http.arn
}
output "alb_zone_id" {
  description = "Hosted zone ID of the ALB"
  value       = aws_lb.this.zone_id
}
