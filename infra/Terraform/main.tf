terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "roca-bucket-aws"         # Nombre del bucket existente
    key            = "state/terraform.tfstate" # Ruta del archivo de estado
    region         = "us-east-1"               # Región del bucket
    dynamodb_table = "terraform-lock"          # Tabla DynamoDB para bloqueo remoto
    encrypt        = true                      # Encriptar estado remoto
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
  vpc_name   = var.vpc_name
  #public_subnet_cidr  = var.public_subnet_cidr
  public_subnet_cidrs = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_name  = var.public_subnet_name
  private_subnet_name = var.private_subnet_name
  gateway_name        = var.gateway_name
  route_table_name    = var.route_table_name
  availability_zone   = var.availability_zone
}

module "alb" {
  source             = "./modules/alb"
  alb_name           = var.alb_name
  target_group_name  = var.target_group_name
  target_port        = var.target_port
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids # Ahora pasamos múltiples subredes
  security_group_ids = [aws_security_group.alb_sg.id]
}

# Reemplazar el módulo ECS por EKS
# Módulo EKS (reemplazando ECS)
module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.ecs_cluster_name # Reutilizamos las variables de ECS para mantener compatibilidad
  kubernetes_version = "1.27"               # Versión de Kubernetes
  cpu                = var.ecs_cpu
  memory             = var.ecs_memory
  execution_role_arn = "" # Ya no necesitamos el rol de ejecución de ECS
  container_name     = var.ecs_container_name
  container_image    = var.ecs_container_image
  container_port     = var.ecs_container_port
  service_name       = var.ecs_service_name
  desired_count      = var.ecs_desired_count
  subnet_ids         = [module.vpc.private_subnet_id]
  security_group_ids = [aws_security_group.ecs_sg.id] # Seguimos usando el mismo grupo de seguridad
  target_group_arn   = module.alb.target_group_arn

  depends_on = [module.alb]
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

resource "aws_security_group" "eks_sg" {
  name        = "${var.environment}-eks-sg"   # Cambiado de ecs-sg a eks-sg
  description = "Security group for EKS pods" # Cambiado de ECS tasks a EKS pods
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
    Name = "${var.environment}-eks-sg"
  }
}

# CloudWatch Monitoring para EKS (reutilizando el módulo de CloudWatch)
module "cloudwatch" {
  source = "./modules/cloudwatch"

  ecs_cluster_name   = module.eks.cluster_name # Ahora apunta al cluster EKS
  ecs_service_name   = module.eks.service_name # Ahora apunta al servicio de EKS
  sns_topic_arn      = ""                      # Deshabilitado para AWS Labs (Lambda/SNS requiere roles IAM)
  cpu_threshold      = var.cpu_threshold
  memory_threshold   = var.memory_threshold
  desired_task_count = var.ecs_desired_count

  depends_on = [module.eks]
}
