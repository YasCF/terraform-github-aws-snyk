# VPC Outputs
output "vpc_id" {
  description = "ID de la VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID de la subred pública"
  #value       = module.vpc.public_subnet_id
  value = module.vpc.public_subnet_ids[0]
}

output "private_subnet_id" {
  description = "ID de la subred privada"
  value       = module.vpc.private_subnet_id
}

# ALB Outputs
output "alb_dns_name" {
  description = "Nombre DNS del Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = module.alb.alb_arn
}

output "target_group_arn" {
  description = "ARN del grupo objetivo del ALB"
  value       = module.alb.target_group_arn
}

# EKS Outputs (anteriormente ECS)
output "ecs_cluster_name" {
  description = "Nombre del cluster (ahora EKS)"
  value       = module.eks.cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN del cluster (ahora EKS)"
  value       = module.eks.cluster_arn
}

output "ecs_service_name" {
  description = "Nombre del servicio (ahora Kubernetes)"
  value       = module.eks.service_name
}

# Este output necesita ser eliminado o modificado ya que EKS no tiene task_definition_arn
# Opción 1: Eliminar el output
# Opción 2: Proporcionar un valor simulado o alternativo
output "ecs_task_definition_arn" {
  description = "ARN de la definición de tarea (simulado para EKS)"
  value       = "arn:aws:eks:${module.eks.cluster_name}:task-definition/simulated"
}

# CloudWatch Outputs (ahora Kubernetes)
output "cluster_cpu_alarm_arn" {
  description = "ARN de la alarma de CPU del cluster Kubernetes"
  value       = module.cloudwatch.ecs_cpu_alarm_arn
}

output "cluster_memory_alarm_arn" {
  description = "ARN de la alarma de memoria del cluster Kubernetes"
  value       = module.cloudwatch.ecs_memory_alarm_arn
}

output "cluster_running_pods_alarm_arn" {
  description = "ARN de la alarma de pods ejecutándose"
  value       = module.cloudwatch.ecs_running_tasks_alarm_arn
}

# Outputs de EKS (reemplazando los de ECS)
output "cluster_name" {
  description = "Nombre del cluster EKS"
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "ARN del cluster EKS"
  value       = module.eks.cluster_arn
}

output "service_name" {
  description = "Nombre del servicio Kubernetes"
  value       = module.eks.service_name
}