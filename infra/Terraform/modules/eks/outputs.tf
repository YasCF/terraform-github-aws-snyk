output "cluster_name" {
  description = "Nombre del cluster EKS"
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "ARN del cluster EKS"
  value       = aws_eks_cluster.this.arn
}

output "service_name" {
  description = "Nombre del servicio Kubernetes (simulado)"
  value       = var.service_name
}

output "service_arn" {
  description = "ARN del servicio Kubernetes (simulado)"
  value       = "arn:aws:eks:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/${aws_eks_cluster.this.name}"
}