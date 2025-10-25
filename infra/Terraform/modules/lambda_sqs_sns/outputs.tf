output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.lambda_function.function_name
}

output "lambda_function_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.lambda_function.arn
}

output "sqs_queue_url" {
  description = "URL de la cola SQS"
  value       = aws_sqs_queue.sqs_queue.id
}

output "sns_topic_arn" {
  description = "ARN del tema SNS"
  value       = aws_sns_topic.sns_topic.arn
}

output "sqs_queue_arn" {
  description = "ARN de la cola SQS"
  value       = aws_sqs_queue.sqs_queue.arn
}