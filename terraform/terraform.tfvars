aws_region           = "us-east-1"
vpc_cidr_block       = "10.0.0.0/16"
public_subnet_cidr   = "10.0.1.0/24"
private_subnet_cidr  = "10.0.2.0/24"
ami                  = "ami-0e2c8caa4b6378d8c" # Verifica que este ID sea válido
instance_type        = "t2.micro"
key_name             = "rsa-Cursodevops"
security_group_name  = "mi-ec2-sg"
instance_name        = "mi-instancia-ec2"
environment          = "dev"

terraform_bucket_name = "mi-terraform-state-bucket1" # Usar para Terraform y Lambda
lambda_zip_file_name  = "lambda_function.zip"        # Archivo ZIP con el código Lambda
lambda_name           = "mi-lambda"
lambda_runtime        = "python3.9"
lambda_handler        = "lambda_function.lambda_handler"
lambda_timeout        = 15
lambda_memory         = 128

sqs_queue_name        = "mi-sqs-queue"
sns_topic_name        = "mi-sns-topic"

cpu_threshold         = 85
network_out_threshold = 1500000
network_in_threshold  = 800000   # 800 KB

dynamodb_table_name   = "terraform-lock"
