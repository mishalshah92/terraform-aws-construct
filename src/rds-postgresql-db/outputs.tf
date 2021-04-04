output "rds_id" {
  value = module.postgresql.id
}

output "rds_arn" {
  value = module.postgresql.arn
}

output "db_username" {
  value = module.postgresql.username
}

output "rds_security_group" {
  value = aws_security_group.rds_sg.id
}

# Secret Manager

output "secret_manager_name" {
  value = aws_secretsmanager_secret.rds_secret_manager.name
}

output "secret_manager_arn" {
  value = aws_secretsmanager_secret.rds_secret_manager.arn
}

# Key

output "kms_key_arn" {
  value = module.postgresql_kms_key.key_arn
}

output "kms_key_id" {
  value = module.postgresql_kms_key.key_id
}

output "kms_key_alias" {
  value = aws_kms_alias.postgresql_kms_key_alias.name
}