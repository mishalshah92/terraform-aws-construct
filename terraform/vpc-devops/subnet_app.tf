locals {
  app_subnet_name         = "${var.vpc_name}-app-subnet"
  app_subnet_rt_name      = "${var.vpc_name}-app-subnet-rt"
  app_subnet_nat_acl_name = "${var.vpc_name}-app-subnet-nat-acl"
  app_subnet_tier         = "app"

  app_subnets = flatten([
    for az, subnet in module.app_subnet : [
      subnet.id
    ]
  ])

}

module "app_subnet" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/vpc-subnet?ref=master"

  for_each = var.app_subnets

  name   = local.app_subnet_name
  vpc_id = module.vpc.vpc_id
  tier   = local.app_subnet_tier

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
  kubernetes_subnet_tags = var.app_subnets_kubernetes_tags
}

module "app_rt" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/vpc-route-table?ref=master"

  name   = local.app_subnet_rt_name
  vpc_id = module.vpc.vpc_id
  tier   = local.app_subnet_tier

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

resource "aws_route_table_association" "app_route_table_association" {

  for_each = module.app_subnet

  route_table_id = module.app_rt.id
  subnet_id      = each.value.id
}

resource "aws_route" "app_nat_gateway_association" {

  route_table_id         = module.app_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.nat_gateway.id
}


resource "aws_network_acl" "app_subnet_net_acl" {

  vpc_id     = module.vpc.vpc_id
  subnet_ids = local.app_subnets

  tags = merge(local.tags, {
    Name = local.app_subnet_nat_acl_name
    Tier = local.app_subnet_tier
  })
}

resource "aws_network_acl_rule" "app_subnet_net_acl_ingress_rules" {

  for_each = var.app_subnets_net_acl_ingress

  network_acl_id = aws_network_acl.app_subnet_net_acl.id
  egress         = false
  rule_number    = each.key
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "app_subnet_net_acl_egress_rules" {

  for_each = var.app_subnets_net_acl_egress

  network_acl_id = aws_network_acl.app_subnet_net_acl.id
  egress         = true
  rule_number    = each.key
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}