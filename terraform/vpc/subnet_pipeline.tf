locals {
  pipeline_subnet_name         = "${var.vpc_name}-pipeline-subnet"
  pipeline_subnet_rt_name      = "${var.vpc_name}-pipeline-subnet-rt"
  pipeline_subnet_nat_acl_name = "${var.vpc_name}-pipeline-subnet-nat-acl"
  pipeline_subnet_tier         = "pipeline"

  pipeline_subnets = flatten([
    for az, subnet in module.pipeline_subnet : [
      subnet.id
    ]
  ])

}

module "pipeline_subnet" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//terraform/vpc-subnet?ref=0.1"

  for_each = var.pipeline_subnets

  name   = local.pipeline_subnet_name
  vpc_id = module.vpc.vpc_id
  tier   = local.pipeline_subnet_tier

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
  kubernetes_subnet_tags = var.pipeline_subnets_kubernetes_tags
}

module "pipeline_rt" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//terraform/vpc-route-table?ref=0.1"

  name   = local.pipeline_subnet_rt_name
  vpc_id = module.vpc.vpc_id
  tier   = local.pipeline_subnet_tier

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

resource "aws_route_table_association" "pipeline_route_table_association" {

  for_each = module.pipeline_subnet

  route_table_id = module.pipeline_rt.id
  subnet_id      = each.value.id
}

resource "aws_route" "pipeline_nat_gateway_association" {

  route_table_id         = module.pipeline_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.nat_gateway.id
}


resource "aws_network_acl" "pipeline_subnet_net_acl" {

  vpc_id     = module.vpc.vpc_id
  subnet_ids = local.pipeline_subnets

  tags = merge(local.tags, {
    Name = local.pipeline_subnet_nat_acl_name
    Tier = local.pipeline_subnet_tier
  })
}

resource "aws_network_acl_rule" "pipeline_subnet_net_acl_ingress_rules" {

  for_each = var.pipeline_subnets_net_acl_ingress

  network_acl_id = aws_network_acl.pipeline_subnet_net_acl.id
  egress         = false
  rule_number    = each.key
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "pipeline_subnet_net_acl_egress_rules" {

  for_each = var.pipeline_subnets_net_acl_egress

  network_acl_id = aws_network_acl.pipeline_subnet_net_acl.id
  egress         = true
  rule_number    = each.key
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}