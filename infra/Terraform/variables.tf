variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
  default     = "mi-vpc"
}

variable "public_subnet_cidr" {
  description = "CIDR block para la subred pública"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block para la subred privada"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_subnet_name" {
  description = "Nombre de la subred pública"
  type        = string
  default     = "mi-subred-publica"
}

variable "private_subnet_name" {
  description = "Nombre de la subred privada"
  type        = string
  default     = "mi-subred-privada"
}

variable "gateway_name" {
  description = "Nombre del Internet Gateway"
  type        = string
  default     = "mi-gateway"
}

variable "route_table_name" {
  description = "Nombre de la tabla de rutas"
  type        = string
  default     = "mi-tabla-rutas"
}

variable "availability_zone" {
  description = "Zona de disponibilidad"
  type        = string
  default     = "us-east-1a"
}

variable "ami" {
  description = "AMI ID para la instancia EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nombre de la clave SSH para la instancia"
  type        = string
}

variable "security_group_name" {
  description = "Nombre del grupo de seguridad"
  type        = string
  default     = "mi-ec2-sg"
}

variable "instance_name" {
  description = "Nombre para la instancia EC2"
  type        = string
  default     = "mi-instancia-ec2"
}


variable "terraform_bucket_name" {
  description = "Nombre del bucket S3 para el estado de Terraform"
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

# Configuración de SQS
variable "sqs_queue_name" {
  description = "Nombre de la cola SQS"
  type        = string
}

# Configuración de SNS
variable "sns_topic_name" {
  description = "Nombre del tema SNS"
  type        = string
}


variable "cpu_threshold" {
  description = "Umbral de uso de CPU para la instancia EC2"
  type        = number
  default     = 80
}

variable "network_out_threshold" {
  description = "Umbral de salida de red (bytes) para la instancia EC2"
  type        = number
  default     = 1000000
}

variable "network_in_threshold" {
  description = "Umbral de datos entrantes para la alarma (en bytes)"
  type        = number
  default     = 500000  # 500 KB
}
variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para el estado de bloqueo remoto"
  type        = string
}

variable "environment" {
  description = "Entorno (e.g., dev, prod)"
  type        = string
}

variable "user_data" {
  description = "Script de configuración para la instancia EC2"
  type        = string
  default     = ""
}
