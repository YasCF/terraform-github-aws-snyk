# Alarma de CPU para ECS Service
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_alarm" {
  alarm_name          = "${var.ecs_service_name}-high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300 # 5 minutos
  statistic           = "Average"
  threshold           = var.cpu_threshold

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_description = "Alarma activada si el uso de CPU del servicio ECS excede el ${var.cpu_threshold}%."
  alarm_actions     = var.sns_topic_arn != "" ? [var.sns_topic_arn] : []

  tags = {
    Name = "${var.ecs_service_name}-cpu-alarm"
  }
}

# Alarma de Memoria para ECS Service
resource "aws_cloudwatch_metric_alarm" "ecs_memory_alarm" {
  alarm_name          = "${var.ecs_service_name}-high-memory-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 300 # 5 minutos
  statistic           = "Average"
  threshold           = var.memory_threshold

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_description = "Alarma activada si el uso de memoria del servicio ECS excede el ${var.memory_threshold}%."
  alarm_actions     = var.sns_topic_arn != "" ? [var.sns_topic_arn] : []

  tags = {
    Name = "${var.ecs_service_name}-memory-alarm"
  }
}

# Alarma de Tareas Ejecutándose
resource "aws_cloudwatch_metric_alarm" "ecs_running_tasks_alarm" {
  alarm_name          = "${var.ecs_service_name}-running-tasks-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "RunningCount"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.desired_task_count
