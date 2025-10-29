variable "cluster_name" {
  description = "Nombre del cluster ECS"
  type        = string
}

variable "task_family" {
  description = "Familia de tareas ECS"
  type        = string
}

variable "cpu" {
  description = "CPU asignada a la tarea (256, 512, 1024, 2048, 4096)"
  type        = string
}

variable "memory" {
  description = "Memoria asignada a la tarea (en MB)"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN del rol de ejecución de tareas ECS"
  type        = string
}

variable "container_name" {
  description = "Nombre del contenedor"
  type        = string
}

variable "container_image" {
  description = "Imagen Docker del contenedor"
  type        = string
}

variable "container_port" {
  description = "Puerto del contenedor"
  type        = number
}

variable "service_name" {
  description = "Nombre del servicio ECS"
  type        = string
}

variable "desired_count" {
  description = "Número deseado de tareas"
  type        = number
}

variable "subnet_ids" {
  description = "IDs de las subredes para las tareas ECS"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs de los grupos de seguridad para las tareas ECS"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN del grupo objetivo del ALB"
  type        = string
}
