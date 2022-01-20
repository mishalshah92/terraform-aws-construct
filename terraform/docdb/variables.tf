variable "region" {
  type = string
}

# Cluster

variable "name" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "master_username" {
  type = string
}

variable "port" {
  type = number
}

variable "deletion_protection" {
  type = bool
}

## Logging

variable "enabled_cloudwatch_logs_exports" {
  type = list(any)
}

## Network

variable "availability_zones" {
  type    = list(any)
  default = null
}

variable "vpc_security_group_ids" {
  type    = list(any)
  default = []
}

variable "db_subnet_group_name" {
  type = string
}

variable "allow_sg_ids" {
  type    = list(any)
  default = []
}

## Maintenance

variable "apply_immediately" {
  type = bool
}

## Backup & Restore

variable "backup_retention_period" {
  type = number
}

variable "preferred_backup_window" {
  type = string
}

variable "skip_final_snapshot" {
  type = bool
}

# Instances

variable "db_instances" {
  type = map(any)
}

# KMS

variable "customer_master_key_spec" {
  type = string
}

variable "deletion_window_in_days" {
  type = number
}

variable "key_usage" {
  type = string
}

variable "is_enabled" {
  type = bool
}

variable "enable_key_rotation" {
  type = bool
}

variable "kms_admin_arn" {
  type    = list(any)
  default = null
}

variable "kms_dev_arn" {
  type    = list(any)
  default = []
}

# Parameter Group

variable "family" {
  type = string
}

variable "parameters" {
  type = map(any)
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