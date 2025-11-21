locals {
  db_subnet_name              = "${var.vpc_name}-db-subnet"
  db_subnet_rt_name           = "${local.db_subnet_name}-rt"
  db_subnet_nat_acl_name      = "${var.vpc_name}-db-subnet-nat-acl"
  db_subnet_group             = "${var.resource_group}-${var.vpc_name}-db-subnet-default"
  db_subnet_elasticache_group = "${var.resource_group}-${var.vpc_name}-db-subnet-default"
  db_subnet_tier              = "db"

  db_subnets = flatten([
    for az, subnet in module.db_subnet : [
      subnet.id
    ]
  ])
}

module "db_subnet" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/vpc-subnet?ref=master"

  for_each = var.db_subnets

  name   = local.db_subnet_name
  vpc_id = module.vpc.vpc_id
  tier   = local.db_subnet_tier

  availability_zone       = each.value.availability_zone
  cidr_block              = each.key
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  customer               = var.customer
  owner                  = var.owner
  env                    = var.env
  email                  = var.email
  git_commit             = var.git_commit
  repo                   = var.repo
  tags                   = var.tags
  resource_group         = var.resource_group
  deployment             = var.deployment
  module                 = var.module
  kubernetes_subnet_tags = var.db_subnets_kubernetes_tags
}

module "db_rt" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/vpc-route-table?ref=master"

  name   = local.db_subnet_rt_name
  vpc_id = module.vpc.vpc_id
  tier   = local.db_subnet_tier

  customer       = var.customer
  owner          = var.owner
  env            = var.env
  email          = var.email
  git_commit     = var.git_commit
  repo           = var.repo
  tags           = var.tags
  resource_group = var.resource_group
  deployment     = var.deployment
  module         = var.module
}

resource "aws_route_table_association" "db_route_table_association" {

  for_each = module.db_subnet

  route_table_id = module.db_rt.id
  subnet_id      = each.value.id
}

resource "aws_route" "db_nat_gateway_association" {

  route_table_id         = module.db_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.nat_gateway.id
}

resource "aws_db_subnet_group" "vpc_db_subnet_group" {

  name       = local.db_subnet_group
  subnet_ids = local.db_subnets

  tags = merge(local.tags, {
    Vpc  = module.vpc.vpc_id
    Name = local.db_subnet_group
  })
}

resource "aws_elasticache_subnet_group" "vpc_db_subnet_elasticache_group" {

  name        = local.db_subnet_elasticache_group
  subnet_ids  = local.db_subnets
  description = "This is elasticache group for db subnet of vpc ${module.vpc.vpc_id}."
}

resource "aws_network_acl" "db_subnet_net_acl" {

  vpc_id     = module.vpc.vpc_id
  subnet_ids = local.db_subnets

  tags = merge(local.tags, {
    Name = local.db_subnet_nat_acl_name
    Tier = local.db_subnet_tier
  })
}

resource "aws_network_acl_rule" "db_subnet_net_acl_ingress_rules" {

  for_each = var.db_subnets_net_acl_ingress

  network_acl_id = aws_network_acl.db_subnet_net_acl.id
  egress         = false
  rule_number    = each.key
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "db_subnet_net_acl_egress_rules" {

  for_each = var.db_subnets_net_acl_egress

  network_acl_id = aws_network_acl.db_subnet_net_acl.id
  egress         = true
  rule_number    = each.key
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}