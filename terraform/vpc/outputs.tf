output "vpc_id" {
  value = module.vpc.vpc_id
}

output "log_group_name" {
  value = module.vpc.log_group_name
}

output "log_group_iam_role" {
  value = module.vpc.log_group_iam_role
}

output "flow_log_id" {
  value = module.vpc.flow_log_id
}

output "flow_log_arn" {
  value = module.vpc.flow_log_id
}

output "pipeline_subnet" {
  value = module.pipeline_subnet
}

output "pipeline_rt" {
  value = module.pipeline_rt.id
}

output "app_subnet" {
  value = module.app_subnet
}

output "app_rt" {
  value = module.app_rt.id
}

output "public_subnet" {
  value = module.public_subnet
}

output "public_rt" {
  value = module.vpc.default_rt_id
}

output "db_subnet" {
  value = module.db_subnet
}

output "db_rt" {
  value = module.db_rt.*.id
}

output "nat_gateway" {
  value = module.nat_gateway.id
}

output "internet_gateway" {
  value = module.public_igw.id
}

output "db_subnet_group_id" {
  value = aws_db_subnet_group.vpc_db_subnet_group.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.vpc_db_subnet_group.name
}

output "elasticache_subnet_group_name" {
  value = aws_elasticache_subnet_group.vpc_db_subnet_elasticache_group.name
}