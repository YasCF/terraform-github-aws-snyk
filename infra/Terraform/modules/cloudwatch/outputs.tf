output "ecs_cpu_alarm_arn" {
  description = "ARN de la alarma de CPU del servicio ECS"
  value       = aws_cloudwatch_metric_alarm.ecs_cpu_alarm.arn
}

output "ecs_memory_alarm_arn" {
  description = "ARN de la alarma de memoria del servicio ECS"
  value       = aws_cloudwatch_metric_alarm.ecs_memory_alarm.arn
}

output "ecs_running_tasks_alarm_arn" {
  description = "ARN de la alarma de tareas ejecutándose"
  value       = aws_cloudwatch_metric_alarm.ecs_running_tasks_alarm.arn
}