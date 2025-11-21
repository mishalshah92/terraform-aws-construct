locals {
  redis_name = "${var.resource_group}-${var.name}"
}

resource "aws_elasticache_parameter_group" "redis_parameter_group" {

  count = var.parameter_group_name == null ? 1 : 0

  name   = local.redis_name
  family = "redis${var.redis_version}"

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameters.value.name
      value = parameters.value.value
    }
  }
}

module "redis-elasticache" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/redis-elasticache?ref=1.7"

  name        = local.redis_name
  description = var.description

  # Redis config
  redis_version = var.redis_version
  redis_port    = var.redis_port

  # Configurations
  subnet_group_name    = var.subnet_group_name == null ? "${var.resource_group}-${data.aws_vpc.selected.tags.Name}-db-subnet-default" : var.subnet_group_name
  parameter_group_name = var.parameter_group_name == null ? aws_elasticache_parameter_group.redis_parameter_group.0.name : var.parameter_group_name

  # Node config
  node_type = var.node_type

  # Networking
  availability_zones = var.availability_zones
  security_group_ids = var.security_group_ids == null ? [aws_security_group.redis_sg.id] : concat([aws_security_group.redis_sg.id], var.security_group_ids)


  # Encryption
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  kms_key_arn                = var.at_rest_encryption_enabled ? module.redis_kms_key.0.key_arn : var.kms_key_arn


  # Backup and maintenance
  maintenance_window         = var.maintenance_window
  snapshot_window            = var.snapshot_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  automatic_failover_enabled = var.automatic_failover_enabled

  # Notification
  notification_topic_arn = var.notification_topic_arn

  # Cluster Mode
  replicas_per_node_group = var.replicas_per_node_group
  num_node_groups         = var.num_node_groups

  # Tags
  customer       = var.customer
  owner          = var.owner
  env            = var.env
  email          = var.email
  repo           = var.repo
  tags           = var.tags
  deployment     = var.deployment
  module         = var.module
  resource_group = var.resource_group
}