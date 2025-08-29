# modules/ecs-taskdef/variables.tf
variable "family" { type = string }
variable "cpu"    { type = string }
variable "memory" { type = string }
variable "region" { type = string }
variable "tags"   { type = map(string) }

variable "containers" {
  type = list(object({
    name               = string
    image              = string
    port               = number
    cpu                = number
    gpu                = string
    memory_hard_limit  = number
    memory_soft_limit  = number
    essential          = bool
    environment        = list(object({ name = string, value = string }))
    dependencies       = list(object({ containerName = string, condition = string }))
    health_check       = optional(object({
      command     = list(string)
      interval    = number
      retries     = number
      startPeriod = number
      timeout     = number
    }), null )
  }))
}

