variable "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  type        = string
}

variable "ecs_service_name" {
  description = "Nombre del servicio ECS"
  type        = string
}

variable "cpu_threshold" {
  description = "Umbral de uso de CPU para las tareas ECS (porcentaje)"
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "Umbral de uso de memoria para las tareas ECS (porcentaje)"
  type        = number
  default     = 85
}

variable "desired_task_count" {
  description = "Número deseado de tareas ECS"
  type        = number
  default     = 2
}

variable "sns_topic_arn" {
  description = "ARN del tema SNS para notificaciones (opcional)"
  type        = string
  default     = ""
}