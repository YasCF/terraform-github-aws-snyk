output "ec2_instance_id" {
  description = "ID de la instancia EC2"
  value       = module.ec2.ec2_instance_id
}

output "public_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = module.ec2.public_ip
}
output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = module.lambda_sqs_sns.lambda_function_name
}

output "sqs_queue_url" {
  description = "URL de la cola SQS"
  value       = module.lambda_sqs_sns.sqs_queue_url
}

output "sns_topic_arn" {
  description = "ARN del tema SNS"
  value       = module.lambda_sqs_sns.sns_topic_arn
}

output "sqs_queue_arn" {
  description = "ARN de la cola SQS"
  value       = module.lambda_sqs_sns.sqs_queue_arn
}