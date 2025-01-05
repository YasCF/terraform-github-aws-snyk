# Crear una alarma para el uso de CPU de EC2
resource "aws_cloudwatch_metric_alarm" "ec2_cpu_alarm" {
  alarm_name          = "${var.ec2_instance_name}-high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_threshold

  dimensions = {
    InstanceId = var.ec2_instance_id
  }

  alarm_description = "Alarma activada si el uso de CPU de EC2 excede el umbral."
  alarm_actions     = [var.sns_topic_arn]
}

# Crear una alarma para la salida de red de EC2
resource "aws_cloudwatch_metric_alarm" "ec2_network_out_alarm" {
  alarm_name          = "${var.ec2_instance_name}-network-out-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.network_out_threshold

  dimensions = {
    InstanceId = var.ec2_instance_id
  }

  alarm_description = "Alarma activada si la salida de red de EC2 excede el umbral."
  alarm_actions     = [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "network_in_alarm" {
  alarm_name          = "mi-instancia-ec2-network-in-alarm"
  comparison_operator = "GreaterThanThreshold" # Activa la alarma si supera el umbral
  evaluation_periods  = 1
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = 60                      # En segundos (1 minuto)
  statistic           = "Average"
  threshold           = 500000                  # Umbral en bytes (500 KB)
  actions_enabled     = true

  alarm_actions     = [var.sns_topic_arn]

  dimensions = {
    InstanceId = var.ec2_instance_id           # ID de la instancia EC2
  }

}
