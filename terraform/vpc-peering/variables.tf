variable "region" {
  type = string
}

# VPC

variable "name" {
  type = string
}

variable "peer_vpc_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "auto_accept" {
  type = bool
}

variable "allow_accepter_remote_vpc_dns_resolution" {
  type = bool
}

variable "allow_requester_remote_vpc_dns_resolution" {
  type = bool
}

variable "requester_acl" {
  type = map
}

variable "accepter_acl" {
  type = map
}

# Routes

variable "requester_routes" {
  type    = map
  default = {}
}

variable "accepter_routes" {
  type    = map
  default = {}
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