module "postgresql_kms_key" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/kms-key-generator?ref=1.7"

  customer_master_key_spec = var.customer_master_key_spec
  description              = "This key is for RDS ${var.name}"
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

resource "aws_kms_alias" "postgresql_kms_key_alias" {
  name_prefix   = "alias/${var.resource_group}/rds/${var.name}"
  target_key_id = module.postgresql_kms_key.key_id
}