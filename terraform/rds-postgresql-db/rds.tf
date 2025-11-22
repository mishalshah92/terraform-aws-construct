locals {
  rds_name = "${var.resource_group}-${var.name}"
}

resource "aws_db_parameter_group" "postgresql_parameter_group" {
  name   = "${var.resource_group}-${var.name}"
  family = var.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.name
      value = parameter.value
    }
  }

  tags = local.tags
}

module "postgresql" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/rds-postgresql?ref=0.1"

  # General
  name                         = local.rds_name
  instance_class               = var.instance_class
  kms_key_arn                  = module.postgresql_kms_key.key_arn
  performance_insights_enabled = var.performance_insights_enabled

  # Database
  engine_version       = var.engine_version
  db_name              = var.db_name
  parameter_group_name = aws_db_parameter_group.postgresql_parameter_group.name
  username             = var.username
  password             = random_password.postgres_password.result

  # Network
  vpc_security_group_ids = length(var.vpc_security_group_ids) > 0 ? merge(aws_security_group.rds_sg.id, var.vpc_security_group_ids) : [aws_security_group.rds_sg.id]
  db_subnet_group_name   = var.db_subnet_group_name
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible

  # Updates
  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade

  # Backup
  backup_retention_period  = var.backup_retention_period
  backup_window_range_utc  = var.backup_window_range_utc
  delete_automated_backups = var.delete_automated_backups
  skip_final_snapshot      = var.skip_final_snapshot

  # Others
  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  deletion_protection   = var.deletion_protection
  maintenance_window    = var.maintenance_window

  # Storage
  iops                      = var.iops
  allocated_storage         = var.allocated_storage
  max_allocated_storage     = var.max_allocated_storage
  storage_type              = var.storage_type
  final_snapshot_identifier = "final-${var.resource_group}-${var.name}-${random_string.random.result}"

  # Monitoring
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn

  # Logging
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

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

resource "random_string" "random" {
  length           = 5
  special          = false
  override_special = "!#$%^&*()"
}