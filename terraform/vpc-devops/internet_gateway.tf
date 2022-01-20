module "public_igw" {
  source = "git::https://github.com/cloudops92/terraform-aws-base-modules.git//src/vpc-internet-gateway?ref=1.2"

  vpc_id = module.vpc.vpc_id

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
    Name = "${var.vpc_name}-igw"
  })
}