module "vpc" {
  source = "git::https://github.com/cloudops92/terraform-aws-base-modules.git//src/vpc?ref=1.2"

  name                 = var.vpc_name
  cidr_range           = var.vpc_cidr_range
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support
  flow_log_retention   = var.vpc_flow_log_retention

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

  # Kubernetes
  kubernetes_vpc_tags = var.kubernetes_vpc_tags

}