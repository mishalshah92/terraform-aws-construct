module "nat_gateway" {
  source = "git::https://github.com/cloudops92/terraform-aws-base-modules.git//src/vpc-nat-gateway?ref=master"

  public_subnet_id = lookup(lookup(module.public_subnet, var.nat_gateway_subnet), "id")

  # Tags
  customer       = var.customer
  owner          = var.owner
  env            = var.env
  email          = var.email
  git_commit     = var.git_commit
  repo           = var.repo
  resource_group = var.resource_group
  deployment     = var.deployment
  module         = var.module

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-nat-gateway"
  })

  depends_on = [
    module.public_subnet
  ]
}