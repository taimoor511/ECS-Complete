# modules/ecs-taskdef/output.tf
output "task_definition_arn" {
  description = "ARN of the ECS Task Definition"
  value       = aws_ecs_task_definition.this.arn
}
output "task_definition_family" {
  description = "Task Definition Family"
  value       = aws_ecs_task_definition.this.family
}
output "task_definition_revision" {
  description = "Revision of the task definition"
  value       = aws_ecs_task_definition.this.revision
}
output "ecs_task_log_group" {
  value       = aws_cloudwatch_log_group.ecs_task.name
  description = "CloudWatch Log Group for ECS task"
}
