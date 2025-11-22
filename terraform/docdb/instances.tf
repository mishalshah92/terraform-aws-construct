module "docdb_instances" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/docdb-cluster-instance?ref=0.1"

  for_each = var.db_instances

  name                         = "${local.db_name}-${each.key}"
  cluster_identifier           = module.docdb.cluster_identifier
  instance_class               = each.value.instance_class
  preferred_maintenance_window = each.value.maintenance_window
  promotion_tier               = each.value.promotion_tier

  # Tags
  customer       = var.customer
  owner          = var.owner
  env            = var.env
  email          = var.email
  repo           = var.repo
  tags           = var.tags
  resource_group = var.resource_group
  deployment     = var.deployment
  module         = var.module

}