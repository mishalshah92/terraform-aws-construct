variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = "Generated using Terraform"
}

# Network

variable "vpc_id" {
  type = string
}

variable "subnet_tier" {
  type = string
}

# Launch Template

variable "create_sg" {
  type = bool
}

variable "keypair_name" {
  type    = string
  default = null
}

variable "iam_instance_profile_name" {
  type    = string
  default = null
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_root_volume_size" {
  type    = number
  default = 35
}

variable "public" {
  type    = bool
  default = false
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "init_config" {
  type    = string
  default = null
}

variable "instance_shutdown_behavior" {
  type    = string
  default = "stop"
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