locals {
  secret_name_prefix = "${var.resource_group}/rds/${var.name}"
}

resource "random_password" "postgres_password" {
  length           = 16
  special          = false
  override_special = "!#$%^&*()"
}

resource "aws_secretsmanager_secret" "rds_secret_manager" {
  name                    = local.secret_name_prefix
  description             = "This secret is credentials of RDS ${module.postgresql.db_name}"
  recovery_window_in_days = 0

  tags = merge(local.tags, {
    RDS = module.postgresql.id
  })
}

resource "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id     = aws_secretsmanager_secret.rds_secret_manager.id
  secret_string = jsonencode(random_password.postgres_password.result)
}