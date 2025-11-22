# general

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpn_cidr" {
  type    = string
  default = "172.31.0.0/16"
}

variable "route_53_zone" {
  type = string
}

variable "private_deploy" {
  type    = bool
  default = true
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.medium"
}

# services

variable "app_ami_id" {
  type = string
}

variable "keypair_name" {
  type = string
}

# tags

variable "customer" {
  type = string
}

variable "env" {
  type = string
}

variable "git_commit" {
  type = string
}

variable "tool" {
  description = "Automation tool info"
  default     = "Managed by Terraform"
}

variable "tags" {
  type = map(string)
}
