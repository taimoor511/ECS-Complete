# modules/ecs-service-securitygroup/main.tf
resource "aws_security_group" "ecs_service_sg" {
  name        = var.sg_name
  description = "Security group for ECS Services"
  vpc_id      = var.vpc_id

  # Allow inbound traffic from ALB SG on container port
  ingress {
    description     = "Allow inbound traffic from ALB SG to ECS service"
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = var.sg_name
    },
    var.tags
  )
}
