output "cluster_name" {
  description = "Nombre del cluster ECS"
  value       = aws_ecs_cluster.this.name
}

output "cluster_arn" {
  description = "ARN del cluster ECS"
  value       = aws_ecs_cluster.this.arn
}

output "service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.this.name
}

output "service_arn" {
  description = "ARN del servicio ECS"
  value       = "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
}

output "task_definition_arn" {
  description = "ARN de la definición de tarea"
  value       = aws_ecs_task_definition.this.arn
}
