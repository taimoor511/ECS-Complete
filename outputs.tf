# (ROOT)output
# VPC
output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnets" { value = module.vpc.public_subnets }
output "private_subnets" { value = module.vpc.private_subnets }
# ALB SG
output "alb_sg_id" { value = module.alb_sg.alb_sg_id }
# Target Group
output "target_group_arn" { value = module.target_group.target_group_arn }
output "target_group_name" { value = module.target_group.target_group_name }
# ALB
output "alb_arn" { value = module.alb.alb_arn }
output "alb_dns_name" { value = module.alb.alb_dns_name }
output "alb_listener_arn" { value = module.alb.alb_listener_arn }
# ECS Cluster
output "ecs_cluster_id" { value = module.ecs_cluster.ecs_cluster_id }
output "ecs_cluster_arn" { value = module.ecs_cluster.ecs_cluster_arn }
output "ecs_cluster_name" { value = module.ecs_cluster.ecs_cluster_name }

# ECS Task Definition outputs
output "task_definition_arn" {
  value = try(module.ecs_taskdef[0].task_definition_arn, null)
}
output "task_definition_family" {
  value = try(module.ecs_taskdef[0].task_definition_family, null)
}
output "task_definition_revision" {
  value = try(module.ecs_taskdef[0].task_definition_revision, null)
}
output "ecs_task_log_group" {
  value = try(module.ecs_taskdef[0].ecs_task_log_group, null)
}

# ECS Service outputs
output "ecs_service_name" {
  value = try(module.ecs_service[0].ecs_service_name, null)
}
output "ecs_service_id" {
  value = try(module.ecs_service[0].ecs_service_id, null)
}
output "ecs_service_arn" {
  value = try(module.ecs_service[0].ecs_service_arn, null)
}

# ACM Certificate
output "acm_certificate_arn" {
  value = var.is_hosted_zone_on_aws ? module.acm[0].certificate_arn : null
}
output "acm_certificate_domain" {
  value = var.is_hosted_zone_on_aws ? module.acm[0].certificate_domain : null
}
output "acm_certificate_validation_status" {
  value = var.is_hosted_zone_on_aws ? module.acm[0].certificate_validation_status : null
}

# HTTPS Listener Outputs
output "https_listener_arn" {
  value = var.is_hosted_zone_on_aws ? module.https_listener[0].https_listener_arn : null
}
output "https_listener_rule_arn" {
  value = var.is_hosted_zone_on_aws ? module.https_listener[0].https_listener_rule_arn : null
}
output "https_record_fqdn" {
  value = var.is_hosted_zone_on_aws ? module.https_listener[0].https_record_fqdn : null
}
