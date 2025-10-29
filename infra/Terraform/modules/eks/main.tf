# Data sources para obtener información de AWS
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# EKS Cluster
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  depends_on = []
}

# Roles IAM existentes: se pasan vía variables 'cluster_role_arn' y 'node_role_arn'

# EKS Node Group
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_count
    max_size     = var.desired_count + 1
    min_size     = 1
  }

  instance_types = ["t3.medium"]
}

# Se eliminan recursos de creación de SG e IAM policies para usar roles/grupos existentes

# Kubernetes Deployment y Service (simulados mediante outputs)
# En un escenario real, usarías el provider de Kubernetes para crear estos recursos
# Pero para mantener la compatibilidad con la interfaz de ECS, solo definimos los outputs