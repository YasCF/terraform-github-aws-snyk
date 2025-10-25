output "alb_dns_name" {
  description = "Nombre DNS del ALB"
  value       = aws_lb.this.dns_name
}

output "alb_arn" {
  description = "ARN del ALB"
  value       = aws_lb.this.arn
}

output "alb_zone_id" {
  description = "Zone ID del ALB"
  value       = aws_lb.this.zone_id
}

output "target_group_arn" {
  description = "ARN del grupo objetivo"
  value       = aws_lb_target_group.this.arn
}
