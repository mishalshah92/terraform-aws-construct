output "id" {
  value = module.docdb.id
}

output "arn" {
  value = module.docdb.arn
}

output "cluster_name" {
  value = module.docdb.cluster_identifier
}

output "endpoint" {
  value = module.docdb.endpoint
}

output "final_snapshot_identifier" {
  value = module.docdb.final_snapshot_identifier
}

output "cluster_resource_id" {
  value = module.docdb.cluster_resource_id
}

output "cluster_members" {
  value = module.docdb.cluster_members
}

output "hosted_zone_id" {
  value = module.docdb.hosted_zone_id
}

# Secret Manager

output "secret_manager_name" {
  value = aws_secretsmanager_secret.docdb_secret_manager.name
}

output "secret_manager_arn" {
  value = aws_secretsmanager_secret.docdb_secret_manager.arn
}

# Primary Instance

output "instances" {
  value = module.docdb_instances
}

# Key

output "kms_key_arn" {
  value = module.docdb_kms_key.key_arn
}

output "kms_key_id" {
  value = module.docdb_kms_key.key_id
}

output "kms_key_alias" {
  value = aws_kms_alias.docdb_kms_key_alias.name
}

# Security Group

output "sg_name" {
  value = aws_security_group.docdb_sg.name
}

output "sg_id" {
  value = aws_security_group.docdb_sg.id
}