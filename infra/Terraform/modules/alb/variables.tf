variable "alb_name" {}
variable "target_group_name" {}
variable "target_port" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}
