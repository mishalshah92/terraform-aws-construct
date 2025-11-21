locals {
  key_count = var.at_rest_encryption_enabled ? (var.kms_key_arn == null ? 1 : 0) : 0
}

module "redis_kms_key" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/kms-key-generator?ref=1.7"

  count = local.key_count

  customer_master_key_spec = var.customer_master_key_spec
  description              = "This key is for Redis ${local.redis_name}"
  deletion_window_in_days  = var.deletion_window_in_days
  enable_key_rotation      = var.enable_key_rotation
  is_enabled               = var.is_enabled
  key_usage                = var.key_usage
  policy                   = data.aws_iam_policy_document.kms_policy_document_admin.json

  # Tags
  customer       = var.customer
  owner          = var.owner
  env            = var.env
  email          = var.email
  repo           = var.repo
  tags           = var.tags
  resource_group = var.resource_group
  deployment     = var.deployment
  module         = var.module
}

resource "aws_kms_alias" "redis_kms_key_alias" {

  count = local.key_count

  name_prefix   = "alias/${var.resource_group}/elasticache/redis/${var.name}"
  target_key_id = module.redis_kms_key.0.key_id
}