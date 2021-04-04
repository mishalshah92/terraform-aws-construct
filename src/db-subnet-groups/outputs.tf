output "db_subnet_group_id" {
  value = aws_db_subnet_group.vpc_db_subnet_group.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.vpc_db_subnet_group.name
}

output "elasticache_subnet_group_name" {
  value = aws_elasticache_subnet_group.vpc_db_subnet_elasticache_group.name
}