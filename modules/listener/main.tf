# modules/listener/main.tf
resource "aws_lb_listener" "https" {
  load_balancer_arn = var.alb_arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
    order            = 1
  }
}

# Optional: Add host header rule
resource "aws_lb_listener_rule" "https_host_header" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  condition {
    host_header {
      values = [var.https_domain]
    }
  }
}

# Optional Route53 Record pointing domain to ALB DNS
resource "aws_route53_record" "https_record" {
  zone_id = var.hosted_zone_id
  name    = var.https_domain
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
