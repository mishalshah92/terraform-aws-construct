locals {
  vpc_name                    = data.aws_vpc.selected.tags.Name
  db_subnet_elasticache_group = "${var.resource_group}-${local.vpc_name}-${var.name}"
}

resource "aws_db_subnet_group" "vpc_db_subnet_group" {
  subnet_ids = var.is_default_vpc ? data.aws_subnet_ids.db_subnets_default.ids : data.aws_subnet_ids.db_subnets[0].ids

  tags = merge(local.tags, {
    Vpc = var.vpc_id
  })
}

resource "aws_elasticache_subnet_group" "vpc_db_subnet_elasticache_group" {

  name        = local.db_subnet_elasticache_group
  subnet_ids  = var.is_default_vpc ? data.aws_subnet_ids.db_subnets_default.ids : data.aws_subnet_ids.db_subnets[0].ids
  description = "This is elasticache group for db subnet of vpc ${var.vpc_id}."
}