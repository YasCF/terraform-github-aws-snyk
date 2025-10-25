# VPC Outputs
output "vpc_id" {
  description = "ID de la VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID de la subred pública"
  value       = module.vpc.public_subnet_id
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

# ECS Outputs
output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN del cluster ECS"
  value       = module.ecs.cluster_arn
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value       = module.ecs.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN de la definición de tarea ECS"
  value       = module.ecs.task_definition_arn
}

# Lambda Outputs
# output "lambda_function_name" {
#   description = "Nombre de la función Lambda"
#   value       = module.lambda_sqs_sns.lambda_function_name
# }

# output "lambda_function_arn" {
#   description = "ARN de la función Lambda"
#   value       = module.lambda_sqs_sns.lambda_function_arn
# }

# SQS Outputs
# output "sqs_queue_url" {
#   description = "URL de la cola SQS"
#   value       = module.lambda_sqs_sns.sqs_queue_url
# }

# output "sqs_queue_arn" {
#   description = "ARN de la cola SQS"
#   value       = module.lambda_sqs_sns.sqs_queue_arn
# }

# SNS Outputs
# output "sns_topic_arn" {
#   description = "ARN del tema SNS"
#   value       = module.lambda_sqs_sns.sns_topic_arn
# }

# CloudWatch Outputs
output "ecs_cpu_alarm_arn" {
  description = "ARN de la alarma de CPU del servicio ECS"
  value       = module.cloudwatch.ecs_cpu_alarm_arn
}

output "ecs_memory_alarm_arn" {
  description = "ARN de la alarma de memoria del servicio ECS"
  value       = module.cloudwatch.ecs_memory_alarm_arn
}

output "ecs_running_tasks_alarm_arn" {
  description = "ARN de la alarma de tareas ejecutándose"
  value       = module.cloudwatch.ecs_running_tasks_alarm_arn
}