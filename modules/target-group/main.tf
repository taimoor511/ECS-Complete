# modules/target-group/main.tf
resource "aws_lb_target_group" "this" {
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  protocol_version = "HTTP1"
  ip_address_type  = "ipv4"

  health_check {
    protocol            = "HTTP"
    port                = var.health_check_port
    path                = var.health_check_path
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
  }

  tags = merge(
    {
      Name = var.target_group_name
    },
    var.tags
  )
}

