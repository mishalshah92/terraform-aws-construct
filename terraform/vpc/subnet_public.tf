locals {
  public_subnet_name         = "${var.vpc_name}-public-subnet"
  public_subnet_rt_name      = "${var.vpc_name}-public-subnet-rt"
  public_subnet_nat_acl_name = "${var.vpc_name}-public-subnet-nat-acl"
  public_subnet_tier         = "public"

  public_subnets = flatten([
    for az, subnet in module.public_subnet : [
      subnet.id
    ]
  ])
}

module "public_subnet" {
  source = "git::https://github.com/cloudops92/terraform-aws-modules//terraform/vpc-subnet?ref=1.4"

  for_each = var.public_subnets

  name   = local.public_subnet_name
  vpc_id = module.vpc.vpc_id
  tier   = local.public_subnet_tier

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
  kubernetes_subnet_tags = var.public_subnets_kubernetes_tags
}

resource "aws_default_route_table" "public_rt" {
  default_route_table_id = module.vpc.default_rt_id

  tags = merge(local.tags, {
    Name = local.public_subnet_rt_name
    Tier = local.public_subnet_tier
  })

  depends_on = [
    module.vpc
  ]
}

resource "aws_route_table_association" "public_rt_association" {

  for_each = module.public_subnet

  route_table_id = module.vpc.default_rt_id
  subnet_id      = each.value.id
}

resource "aws_route" "public_internet_gateway_association" {

  route_table_id         = module.vpc.default_rt_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.public_igw.id
}

resource "aws_default_network_acl" "public_subnet_net_acl" {

  default_network_acl_id = module.vpc.default_net_acl_id
  subnet_ids             = local.public_subnets


  dynamic "ingress" {
    for_each = var.public_subnets_net_acl_ingress
    content {
      rule_no    = ingress.key
      protocol   = ingress.value.protocol
      action     = ingress.value.rule_action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = var.public_subnets_net_acl_egress
    content {
      rule_no    = egress.key
      protocol   = egress.value.protocol
      action     = egress.value.rule_action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  tags = merge(local.tags, {
    Name = local.public_subnet_nat_acl_name
    Tier = local.public_subnet_tier
  })
}