module "client-vpn-endpoint" {
  source = "git::https://github.com/cloudops92/terraform-aws-base-modules.git//src/client-vpn-endpoint?ref=1.2"

  name        = var.name
  description = "The VPN endpoint for VPC ${var.customer}. VPC ${data.aws_vpc.vpn_vpc.id}"

  auth_type                       = var.auth_type
  auth_root_certificate_chain_arn = data.aws_acm_certificate.client_cert.arn

  client_cidr_block = var.client_cidr_block
  dns_servers       = var.dns_servers == [] ? [data.aws_vpc.vpn_vpc.cidr_block] : var.dns_servers

  log_retention = var.log_retention

  server_certificate_arn = data.aws_acm_certificate.root_cert.arn
  split_tunnel           = var.split_tunnel

  # Tags
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

module "vpn_network_association" {
  source = "git::https://github.com/cloudops92/terraform-aws-base-modules.git//src/client-vpn-network-association?ref=1.2"

  for_each = toset(var.association_subnet_ids)

  client_vpn_endpoint_id = module.client-vpn-endpoint.id
  subnet_id              = each.key
  security_groups = [
    aws_security_group.vpn_sg.id
  ]

}

module "authorization_rules" {
  source = "git::https://github.com/cloudops92/terraform-aws-base-modules.git//src/client-vpn-authorization-rule?ref=1.2"

  for_each = data.aws_subnet.selected

  client_vpn_endpoint_id = module.client-vpn-endpoint.id
  target_network_cidr    = each.value.cidr_block
  description            = "Allowing ${each.value.cidr_block} traffic from ${each.value.id}"
}