# modules/ecs-service-securitygroup/output.tf:
output "ecs_service_sg_id" {
  description = "The ID of the ECS service security group"
  value       = aws_security_group.ecs_service_sg.id
}
