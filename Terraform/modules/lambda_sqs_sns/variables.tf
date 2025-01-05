variable "terraform_bucket_name" {
  description = "Nombre del bucket S3 para almacenar el archivo Lambda"
  type        = string
}

variable "lambda_zip_file_name" {
  description = "Nombre del archivo ZIP que contiene el código Lambda"
  type        = string
}

variable "lambda_name" {
  description = "Nombre de la función Lambda"
  type        = string
}

variable "lambda_runtime" {
  description = "Runtime de Lambda"
  type        = string
}

variable "lambda_handler" {
  description = "Handler de Lambda"
  type        = string
}

variable "lambda_timeout" {
  description = "Timeout de Lambda (en segundos)"
  type        = number
}

variable "lambda_memory" {
  description = "Memoria asignada a Lambda (en MB)"
  type        = number
}

variable "sqs_queue_name" {
  description = "Nombre de la cola SQS"
  type        = string
}

variable "sns_topic_name" {
  description = "Nombre del tema SNS"
  type        = string
}

variable "environment" {
  description = "Entorno (e.g., dev, prod)"
  type        = string
}
