variable "region" {
  type = string
}

# EKS Master

variable "cluster_name" {
  type = string
}

# Node variables

//variable "node_groups" {
//  type = map
//}

variable "node_group_name" {
  type = string
}

variable "node_labels" {
  type = map(string)
}

variable "instance_types" {
  type = string
}

variable "instance_disk_size" {
  type = number
}

variable "ami_type" {
  type = string
}

variable "scaling_desiered_size" {
  type = number
}

variable "scaling_max_size" {
  type = number
}

variable "scaling_min_size" {
  type = number
}

variable "node_ssh_sg_ids" {
  type = list(string)
}

variable "node_ssh_keypair_name" {
  type = string
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

variable "tags" {
  type    = map(string)
  default = {}
}