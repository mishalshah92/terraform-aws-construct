module "resource_group" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/resource-group?ref=1.8"

  name                  = "${var.customer}-${var.env}"
  resource_type_filters = var.resource_type_filters
  tag_filters = [
    {
      Key : "Customer",
      Values : [
        var.customer
      ]
    },
    {
      Key : "Env"
      Values : [
        var.env
      ]
    }
  ]

  # Tags
  customer   = var.customer
  owner      = var.owner
  env        = var.env
  email      = var.email
  repo       = var.repo
  tags       = var.tags
  deployment = var.deployment
  module     = var.module
}