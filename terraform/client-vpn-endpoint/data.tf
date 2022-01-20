data "aws_vpc" "vpn_vpc" {
  id = var.vpc_id
}

data "aws_sns_topic" "rg_default" {
  name = var.resource_group
}

data "aws_security_group" "default_sg" {
  name   = "default"
  vpc_id = data.aws_vpc.vpn_vpc.id
}

data "aws_subnet" "selected" {

  for_each = toset(var.subnets)

  id = each.key
}


data "aws_acm_certificate" "root_cert" {
  domain      = var.root_cert_domain
  statuses    = ["ISSUED"]
  types       = ["IMPORTED"]
  most_recent = true
}

data "aws_acm_certificate" "client_cert" {
  domain      = var.client_cert_domain
  statuses    = ["ISSUED"]
  types       = ["IMPORTED"]
  most_recent = true
}

data "aws_network_acls" "subnet_net_acl" {

  vpc_id = var.vpc_id

  filter {
    name   = "association.subnet-id"
    values = var.subnets
  }
}