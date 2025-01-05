terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "mi-terraform-state-bucket1" # Nombre del bucket existente
    key            = "state/terraform.tfstate"   # Ruta del archivo de estado
    region         = "us-east-1"                # Región del bucket
    dynamodb_table = "terraform-lock"           # Tabla DynamoDB para bloqueo remoto
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "./Terraform/modules/vpc"
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

module "ec2" {
  source              = "./Terraform/modules/ec2"
  ami                 = var.ami
  instance_type       = var.instance_type
  key_name            = var.key_name
  subnet_id           = module.vpc.public_subnet_id  # Usar la subred pública creada
  vpc_id              = module.vpc.vpc_id           # Usar la VPC creada
  security_group_name = var.security_group_name
  instance_name       = var.instance_name
  user_data           = var.user_data
  environment         = var.environment
}


module "lambda_sqs_sns" {
  source               = "./Terraform/modules/lambda_sqs_sns"
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



module "cloudwatch" {
  source                 = "./Terraform/modules/cloudwatch"
  ec2_instance_id        = module.ec2.ec2_instance_id
  ec2_instance_name      = var.instance_name
  sns_topic_arn          = module.lambda_sqs_sns.sns_topic_arn
  cpu_threshold          = var.cpu_threshold
  network_out_threshold  = var.network_out_threshold
  network_in_threshold   = var.network_in_threshold
}
