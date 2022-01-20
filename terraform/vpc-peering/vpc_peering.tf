locals {
  name = "${var.resource_group}/${var.name}"
}

module "vpc-peering" {
  source = "git::https://github.com/cloudops92/terraform-aws-modules//terraform/vpc-peering?ref=1.2"

  name        = local.name
  vpc_id      = var.vpc_id
  auto_accept = true

  # Peering
  peer_vpc_id = var.peer_vpc_id

  # Config
  allow_accepter_remote_vpc_dns_resolution  = var.allow_accepter_remote_vpc_dns_resolution
  allow_requester_remote_vpc_dns_resolution = var.allow_requester_remote_vpc_dns_resolution

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