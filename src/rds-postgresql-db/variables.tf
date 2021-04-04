variable "region" {
  type = string
}

variable "allow_sg_ids" {
  type    = list(any)
  default = []
}

variable "performance_insights_enabled" {
  type    = bool
  default = false
}

# Parameter Group

variable "family" {
  type = string
}

variable "parameters" {
  type = map(any)
}

# General

variable "name" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "port" {
  type    = number
  default = 5432
}

# Database

variable "engine_version" {
  type = string
}

variable "db_name" {
  type    = string
  default = null
}

variable "username" {
  type = string
}

# Network

variable "vpc_security_group_ids" {
  type    = list(any)
  default = []
}

variable "db_subnet_group_name" {
  type = string
}

variable "multi_az" {
  type = bool
}

variable "publicly_accessible" {
  type = bool
}

# Updates

variable "allow_major_version_upgrade" {
  type = bool
}

variable "apply_immediately" {
  type = bool
}

variable "auto_minor_version_upgrade" {
  type = bool
}

# Backup

variable "backup_retention_period" {
  type    = number
  default = 0
}

variable "backup_window_range_utc" {
  type = string
}

variable "delete_automated_backups" {
  type = bool
}

variable "skip_final_snapshot" {
  type = bool
}

# Others

variable "copy_tags_to_snapshot" {
  type = bool
}

variable "deletion_protection" {
  type = string
}

variable "maintenance_window" {
  description = "Format of rage is {ddd:hh24:mi-ddd:hh24:mi}. Eg: {Mon:00:00-Mon:03:00}."
  type        = string
}

# Storage

variable "iops" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  type = number
}

variable "storage_type" {
  type = string
}

# Monitoring

variable "monitoring_interval" {
  type = number
}

variable "monitoring_role_arn" {
  type = string
}

# Logging

variable "enabled_cloudwatch_logs_exports" {
  type = list(any)
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


# Monitoring

variable "alerts" {
  type    = map(any)
  default = {}
}

variable "alarm_actions_arn" {
  type    = list(any)
  default = null
}

variable "alarm_cpu_credit_balance_threshold" {
  type    = number
  default = 30
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