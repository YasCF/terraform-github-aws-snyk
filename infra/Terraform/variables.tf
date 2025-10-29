variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr_block" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
  default     = "roca-vpc"
}

variable "public_subnet_cidrs" {
  description = "CIDR block para la subred pública"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidr" {
  description = "CIDR block para la subred privada"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_subnet_name" {
  description = "Nombre de la subred pública"
  type        = string
  default     = "public-subnet"
}

variable "private_subnet_name" {
  description = "Nombre de la subred privada"
  type        = string
  default     = "private-subnet"
}

variable "gateway_name" {
  description = "Nombre del Internet Gateway"
  type        = string
  default     = "roca-igw"
}

variable "route_table_name" {
  description = "Nombre de la tabla de rutas"
  type        = string
  default     = "public-route-table"
}

variable "availability_zone" {
  description = "Zona de disponibilidad"
  type        = string
  default     = "us-east-1a"
}


# ALB Configuration
variable "alb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
  default     = "roca-alb"
}

variable "target_group_name" {
  description = "Nombre del grupo objetivo del ALB"
  type        = string
  default     = "ecs-target-group"
}

variable "target_port" {
  description = "Puerto del grupo objetivo"
  type        = number
  default     = 80

  validation {
    condition     = var.target_port > 0 && var.target_port <= 65535
    error_message = "El puerto debe estar entre 1 y 65535."
  }
}

# ECS Configuration
variable "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  type        = string
  default     = "roca-cluster"
}

variable "ecs_task_family" {
  description = "Familia de tareas ECS"
  type        = string
  default     = "roca-task"
}

variable "ecs_cpu" {
  description = "CPU asignada a la tarea ECS (en unidades CPU)"
  type        = string
  default     = "256"

  validation {
    condition     = contains(["256", "512", "1024", "2048", "4096"], var.ecs_cpu)
    error_message = "El CPU debe ser 256, 512, 1024, 2048 o 4096."
  }
}

variable "ecs_memory" {
  description = "Memoria asignada a la tarea ECS (en MB)"
  type        = string
  default     = "512"
}

variable "ecs_container_name" {
  description = "Nombre del contenedor ECS"
  type        = string
  default     = "roca-app-container"
}

variable "ecs_container_image" {
  description = "Imagen Docker para el contenedor ECS"
  type        = string
}

variable "ecs_container_port" {
  description = "Puerto del contenedor ECS"
  type        = number
  default     = 8080
}

variable "ecs_service_name" {
  description = "Nombre del servicio ECS"
  type        = string
  default     = "roca-service"
}

variable "ecs_desired_count" {
  description = "Número deseado de tareas ECS"
  type        = number
  default     = 2
}

# Lambda Configuration
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
  description = "Runtime de Lambda (ej: python3.11, nodejs18.x)"
}

variable "lambda_handler" {
  description = "Handler de Lambda (ej: index.handler)"
  type        = string
}

variable "lambda_timeout" {
  description = "Timeout de Lambda (en segundos)"
  type        = number
  default     = 60
}

variable "lambda_memory" {
  description = "Memoria asignada a Lambda (en MB)"
  type        = number
  default     = 128
}

# SQS Configuration
variable "sqs_queue_name" {
  description = "Nombre de la cola SQS"
  type        = string
}

# SNS Configuration
variable "sns_topic_name" {
  description = "Nombre del tema SNS"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para el estado de bloqueo remoto"
  type        = string
}

# CloudWatch Configuration
variable "cpu_threshold" {
  description = "Umbral de uso de CPU para las tareas ECS (porcentaje)"
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "Umbral de uso de memoria para las tareas ECS (porcentaje)"
  type        = number
  default     = 85
}
