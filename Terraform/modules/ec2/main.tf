# Instancia EC2
resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id  # Recibido desde el módulo principal

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = file("${path.module}/../resources/bootstrap.sh")

  tags = {
    Name = var.instance_name
  }
}

# Grupo de Seguridad asociado a la VPC
resource "aws_security_group" "ec2_sg" {
  name        = var.security_group_name
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id  # Recibido desde el módulo principal

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name        = var.security_group_name
    Environment = var.environment
  }
}
