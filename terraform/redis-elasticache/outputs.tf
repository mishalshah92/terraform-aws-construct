output "id" {
  value = module.redis-elasticache.id
}

output "configuration_endpoint_address" {
  value = module.redis-elasticache.configuration_endpoint_address
}

output "primary_endpoint_address" {
  value = module.redis-elasticache.primary_endpoint_address
}

output "member_clusters" {
  value = module.redis-elasticache.member_clusters
}

output "redis_sg" {
  value = aws_security_group.redis_sg.id
}

output "redis_sg_name" {
  value = aws_security_group.redis_sg.name
}