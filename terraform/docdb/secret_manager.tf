locals {
  secret_name_prefix = "${var.resource_group}/docdb/${var.name}"
}

resource "random_password" "docdb_password" {
  length           = 16
  special          = false
  override_special = "!#$%^&*()"
}

resource "aws_secretsmanager_secret" "docdb_secret_manager" {
  name                    = local.secret_name_prefix
  description             = "This secret is credentials of DocDB Cluster ${var.name}"
  recovery_window_in_days = 0

  tags = merge(local.tags, {
    DocDB = module.docdb.id
  })
}

resource "aws_secretsmanager_secret_version" "docdb_secret" {
  secret_id     = aws_secretsmanager_secret.docdb_secret_manager.id
  secret_string = jsonencode(random_password.docdb_password.result)
}