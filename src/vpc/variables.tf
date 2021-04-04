variable "region" {
  type = string
}

# VPC

variable "vpc_name" {
  type = string
}

variable "vpc_cidr_range" {
  type = string
}

variable "vpc_enable_dns_hostnames" {
  type = bool
}

variable "vpc_enable_dns_support" {
  type = bool
}

variable "vpc_flow_log_retention" {
  type = number
}

variable "kubernetes_vpc_tags" {
  type    = map(string)
  default = {}
}

# Public Subnet

variable "public_subnets" {
  type    = map(any)
  default = {}
}

variable "public_subnets_net_acl_ingress" {
  type    = map(any)
  default = {}
}

variable "public_subnets_net_acl_egress" {
  type    = map(any)
  default = {}
}

variable "public_subnets_kubernetes_tags" {
  type    = map(any)
  default = {}
}

# App Subnet

variable "app_subnets" {
  type    = map(any)
  default = {}
}

variable "app_subnets_kubernetes_tags" {
  type    = map(any)
  default = {}
}

variable "app_subnets_net_acl_ingress" {
  type    = map(any)
  default = {}
}

variable "app_subnets_net_acl_egress" {
  type    = map(any)
  default = {}
}

# Pipeline Subnet

variable "pipeline_subnets" {
  type    = map(any)
  default = {}
}

variable "pipeline_subnets_kubernetes_tags" {
  type    = map(any)
  default = {}
}

variable "pipeline_subnets_net_acl_ingress" {
  type    = map(any)
  default = {}
}

variable "pipeline_subnets_net_acl_egress" {
  type    = map(any)
  default = {}
}

# DB Subnet

variable "db_subnets" {
  type    = map(any)
  default = {}
}

variable "db_subnets_kubernetes_tags" {
  type    = map(any)
  default = {}
}

variable "db_subnets_net_acl_ingress" {
  type    = map(any)
  default = {}
}

variable "db_subnets_net_acl_egress" {
  type    = map(any)
  default = {}
}

# nat gateways

variable "nat_gateway_subnet" {
  type = string
}

# tags
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