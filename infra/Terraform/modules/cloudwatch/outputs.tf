output "ec2_cpu_alarm" {
  description = "ARN de la alarma de uso de CPU de EC2"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu_alarm.arn
}

output "ec2_network_out_alarm" {
  description = "ARN de la alarma de salida de red de EC2"
  value       = aws_cloudwatch_metric_alarm.ec2_network_out_alarm.arn
}

output "network_in_alarm_arn" {
  description = "ARN de la alarma de NetworkIn"
  value       = aws_cloudwatch_metric_alarm.network_in_alarm.arn
}