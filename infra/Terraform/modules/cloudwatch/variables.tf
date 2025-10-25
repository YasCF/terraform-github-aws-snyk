variable "ecs_cluster_name" {
  description = "Nombre del cluster (EKS o ECS)"
  type        = string
}

variable "ecs_service_name" {
  description = "Nombre del servicio (Kubernetes o ECS)"
  type        = string
}

variable "cpu_threshold" {
  description = "Umbral de uso de CPU para los nodos (porcentaje)"
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "Umbral de uso de memoria para los nodos (porcentaje)"
  type        = number
  default     = 85
}

variable "desired_task_count" {
  description = "Número deseado de nodos/pods"
  type        = number
  default     = 2
}

variable "sns_topic_arn" {
  description = "ARN del tema SNS para notificaciones (opcional)"
  type        = string
  default     = ""
}