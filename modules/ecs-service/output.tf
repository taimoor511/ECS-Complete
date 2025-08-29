# modules/ecs-service/output.tf:
output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.this.name
}

output "ecs_service_id" {
  description = "ECS service ID (also the ARN)"
  value       = aws_ecs_service.this.id
}

output "ecs_service_arn" {
  description = "ECS service ARN (same as ID)"
  value       = aws_ecs_service.this.id
}

