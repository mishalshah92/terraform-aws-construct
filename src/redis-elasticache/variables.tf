variable "region" {
  type = string
}

variable "allow_sg_ids" {
  type    = list(any)
  default = []
}

# Parameter Group

variable "parameters" {
  type    = list(any)
  default = []
}

# Redis

variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = null
}

## Redis config

variable "redis_version" {
  type = string
}

variable "redis_port" {
  type    = number
  default = 6379
}

## Configurations

variable "subnet_group_name" {
  type    = string
  default = null
}

variable "parameter_group_name" {
  type    = string
  default = null
}

## Node config

variable "node_type" {
  type = string
}

## Network

variable "vpc_id" {
  type = string
}

variable "availability_zones" {
  type = list(any)
}

variable "security_group_ids" {
  type    = list(any)
  default = null
}

## Failover

variable "automatic_failover_enabled" {
  type = bool
}

variable "auto_minor_version_upgrade" {
  type = bool
}

variable "maintenance_window" {
  type = string
}

variable "snapshot_window" {
  type = string
}

variable "snapshot_retention_limit" {
  type = number
}

variable "apply_immediately" {
  type    = bool
  default = false
}

## Encryption

variable "at_rest_encryption_enabled" {
  type = bool
}

variable "transit_encryption_enabled" {
  type = bool
}

variable "kms_key_arn" {
  type    = string
  default = null
}

## Notification
variable "notification_topic_arn" {
  type    = string
  default = null
}

## Cluster mode

variable "replicas_per_node_group" {
  type = number
}

variable "num_node_groups" {
  type = number
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