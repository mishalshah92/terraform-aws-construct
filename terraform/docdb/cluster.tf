locals {
  db_name                   = "${var.resource_group}-${var.name}"
  timestamp                 = replace(replace(timestamp(), ":", ""), "-", "")
  final_snapshot_identifier = "${var.name}-${local.timestamp}"
}

resource "aws_docdb_cluster_parameter_group" "docdb_parameter_group" {
  name_prefix = local.db_name
  family      = var.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.name
      value = parameter.value
    }
  }

  tags = local.tags
}

module "docdb" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/docdb-cluster?ref=1.7"

  name            = local.db_name
  engine_version  = var.engine_version
  master_password = random_password.docdb_password.result
  master_username = var.master_username
  port            = var.port

  deletion_protection = var.deletion_protection

  # Storage
  storage_encrypted = true
  kms_key_id        = module.docdb_kms_key.key_arn

  # Logging
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # Network
  availability_zones              = var.availability_zones == null ? data.aws_availability_zones.availability_zones.names : var.availability_zones
  vpc_security_group_ids          = concat([aws_security_group.docdb_sg.id], var.vpc_security_group_ids)
  db_subnet_group_name            = var.db_subnet_group_name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.docdb_parameter_group.name

  # backup
  backup_retention_period   = var.backup_retention_period
  preferred_backup_window   = var.preferred_backup_window
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = local.final_snapshot_identifier

  # Maintenance
  apply_immediately = var.apply_immediately

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