# modules/ecs-taskdef/main.tf
resource "aws_ecs_task_definition" "this" {
  family                   = var.family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"

  container_definitions = jsonencode(
    [for c in var.containers : {
      name      = c.name
      image     = c.image
      essential = c.essential

      portMappings = [
        {
          containerPort = c.port
          hostPort      = c.port
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]

      resourceRequirements = (
        length(c.gpu) > 0 ? [{ type = "GPU", value = c.gpu }] : []
      )

      cpu               = c.cpu
      memoryReservation = c.memory_soft_limit
      memory            = c.memory_hard_limit
      environment       = c.environment

      healthCheck = c.health_check != null ? {
        command     = c.health_check.command
        interval    = c.health_check.interval
        retries     = c.health_check.retries
        startPeriod = c.health_check.startPeriod
        timeout     = c.health_check.timeout
      } : null

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.family}"
          awslogs-region        = var.region
          awslogs-stream-prefix = c.name
        }
      }

      dependsOn = length(c.dependencies) > 0 ? [
        for d in c.dependencies : {
          containerName = d.containerName
          condition     = d.condition
        }
      ] : null
    }]
  )

  tags = var.tags
}

data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_log_group" "ecs_task" {
  name              = "/ecs/${var.family}"
  retention_in_days = 7
  tags              = var.tags
}
