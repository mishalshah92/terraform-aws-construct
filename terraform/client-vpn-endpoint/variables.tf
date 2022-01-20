variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "root_cert_domain" {
  type = string
}

variable "client_cert_domain" {
  type = string
}

variable "association_subnet_ids" {
  type = list(any)
}

# VPN

## Authentication

variable "auth_type" {
  type = string
}

## Logging

variable "log_retention" {
  type = number
}

## Other

variable "client_cidr_block" {
  type = string
}

variable "dns_servers" {
  type    = list(any)
  default = []
}

variable "split_tunnel" {
  type = bool
}

variable "transport_protocol" {
  type = string
}

variable "subnets" {
  type = list(any)
}

# Cloudwatch

variable "alerts" {
  type    = map(any)
  default = {}
}

variable "alarm_actions_arn" {
  type    = list(any)
  default = null
}

# Tags

variable "customer" {
  type = string
}

variable "owner" {
  type = string
}

variable "email" {
  type = string
}

variable "env" {
  type = string
}

variable "git_commit" {
  type = string
}

variable "repo" {
  type = string
}

variable "tool" {
  description = "Automation tool info"
  default     = "Managed by Terraform"
}

variable "resource_group" {
  type = string
}

variable "deployment" {
  type = string
}

variable "module" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}