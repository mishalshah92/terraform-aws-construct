variable "region" {
  type = string
}

variable "resource_type_filters" {
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

# Slack

variable "slack_webhook_url" {
  type = string
}

variable "slack_channel" {
  type = string
}

variable "slack_cloudwatch_log_group_retention_in_days" {
  type    = number
  default = 90
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