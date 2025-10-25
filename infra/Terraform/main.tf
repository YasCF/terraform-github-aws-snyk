terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "mi-terraform-state-bucket1" # Nombre del bucket existente
    key            = "state/terraform.tfstate"   # Ruta del archivo de estado
    region         = "us-east-1"                # Región del bucket
    dynamodb_table = "terraform-lock"           # Tabla DynamoDB para bloqueo remoto
    encrypt        = true                       # Encriptar estado remoto
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = var.vpc_cidr_block
  vpc_name            = var.vpc_name
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_name  = var.public_subnet_name
  private_subnet_name = var.private_subnet_name
  gateway_name        = var.gateway_name
  route_table_name    = var.route_table_name
  availability_zone   = var.availability_zone
}

module "alb" {
  source              = "./modules/alb"
  alb_name            = var.alb_name
  target_group_name   = var.target_group_name
  target_port         = var.target_port
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = [module.vpc.public_subnet_id]
  security_group_ids  = [aws_security_group.alb_sg.id]
}

module "ecs" {
  source              = "./modules/ecs"
  cluster_name        = var.ecs_cluster_name
  task_family         = var.ecs_task_family
  cpu                 = var.ecs_cpu
  memory              = var.ecs_memory
  execution_role_arn  = aws_iam_role.ecs_task_execution_role.arn
  container_name      = var.ecs_container_name
  container_image     = var.ecs_container_image
  container_port      = var.ecs_container_port
  service_name        = var.ecs_service_name
  desired_count       = var.ecs_desired_count
  subnet_ids          = [module.vpc.private_subnet_id]
  security_group_ids  = [aws_security_group.ecs_sg.id]
  target_group_arn    = module.alb.target_group_arn
  
  depends_on = [module.alb]
}

module "lambda_sqs_sns" {
  source               = "./modules/lambda_sqs_sns"
  terraform_bucket_name = var.terraform_bucket_name # Reutilizar el bucket del tfstate
  lambda_zip_file_name  = var.lambda_zip_file_name
  lambda_name           = var.lambda_name
  lambda_runtime        = var.lambda_runtime
  lambda_handler        = var.lambda_handler
  lambda_timeout        = var.lambda_timeout
  lambda_memory         = var.lambda_memory
  sqs_queue_name        = var.sqs_queue_name
  sns_topic_name        = var.sns_topic_name
  environment           = var.environment
}



# Security Groups
resource "aws_security_group" "alb_sg" {
  name        = "${var.environment}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-alb-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.environment}-ecs-sg"
  description = "Security group for ECS tasks"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = var.ecs_container_port
    to_port         = var.ecs_container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-ecs-sg"
    Environment = var.environment
  }
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.environment}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.environment}-ecs-task-execution-role"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
