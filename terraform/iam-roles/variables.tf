# general

variable "region" {
  type    = string
  default = "ap-south-1"
}

# Roles

variable "name" {
  type = string
}

variable "max_session_duration" {
  type = string
}

variable "policies" {
  type    = list(string)
  default = []
}

variable "instance_profile" {
  type    = bool
  default = false
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
