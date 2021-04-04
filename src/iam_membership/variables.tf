# general

variable "region" {
  type    = string
  default = "ap-south-1"
}

# Roles

variable "roles" {
  type    = map
  default = {}
}

variable "role_instance_profiles" {
  type    = list
  default = []
}

variable "role_policies" {
  type    = map
  default = {}
}

# Groups

variable "groups" {
  type    = map
  default = {}
}

# tags

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

variable "tags" {
  type    = map(string)
  default = {}
}
