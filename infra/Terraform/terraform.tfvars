# AWS Configuration
aws_region  = "us-east-1"
environment = "dev"

# VPC Configuration
vpc_cidr_block      = "10.0.0.0/16"
vpc_name            = "roca-vpc"
public_subnet_cidr  = "10.0.1.0/24"
public_subnet_name  = "roca-public-subnet"
private_subnet_cidr = "10.0.2.0/24"
private_subnet_name = "roca-private-subnet"
gateway_name        = "roca-igw"
route_table_name    = "roca-route-table"

# ALB Configuration
alb_name          = "roca-alb"
target_group_name = "roca-tg"
target_port       = 80

# EKS Configuration (anteriormente ECS)
ecs_cluster_name    = "roca-cluster"       # Ahora usado para EKS
ecs_task_family     = "roca-task"          # Mantenido por compatibilidad
ecs_cpu             = "256"                # Ahora usado para EKS
ecs_memory          = "512"                # Ahora usado para EKS
ecs_container_name  = "roca-app-container" # Ahora usado para EKS
ecs_container_image = "nginx:latest"       # Ahora usado para EKS
ecs_container_port  = 80                   # Ahora usado para EKS
ecs_service_name    = "roca-service"       # Ahora usado para EKS
ecs_desired_count   = 2                    # Ahora usado para EKS

# Lambda Configuration
terraform_bucket_name = "mi-terraform-state-bucket1"
lambda_zip_file_name  = "lambda_function.zip"
lambda_name           = "roca-lambda"
lambda_runtime        = "python3.11"
lambda_handler        = "lambda_function.lambda_handler"
lambda_timeout        = 60
lambda_memory         = 256

# SQS Configuration
sqs_queue_name = "roca-sqs-queue"

# SNS Configuration
sns_topic_name = "roca-sns-topic"

# CloudWatch Configuration
cpu_threshold    = 80
memory_threshold = 85

# Terraform Backend
dynamodb_table_name = "terraform-lock"