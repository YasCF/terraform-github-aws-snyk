variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "kubernetes_version" {
  description = "Versión de Kubernetes para el cluster EKS"
  type        = string
  default     = "1.27"
}

variable "subnet_ids" {
  description = "IDs de las subredes para el cluster EKS"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs de los grupos de seguridad para el cluster EKS"
  type        = list(string)
}

variable "service_name" {
  description = "Nombre del servicio Kubernetes"
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

variable "desired_count" {
  description = "Número deseado de réplicas"
  type        = number
}

variable "cpu" {
  description = "CPU asignada al contenedor (en unidades de CPU)"
  type        = string
}

variable "memory" {
  description = "Memoria asignada al contenedor (en MB)"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN del rol de ejecución (opcional para EKS)"
  type        = string
  default     = ""
}

variable "target_group_arn" {
  description = "ARN del grupo objetivo del ALB"
  type        = string
}

variable "task_family" {
  description = "Familia de tareas"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "ID de la VPC donde desplegar los recursos de EKS"
  type        = string
}

variable "environment" {
  description = "Nombre del ambiente para etiquetado"
  type        = string
}

variable "cluster_role_arn" {
  description = "ARN del rol IAM existente para el cluster EKS"
  type        = string
}

variable "node_role_arn" {
  description = "ARN del rol IAM existente para los nodos de EKS"
  type        = string
}