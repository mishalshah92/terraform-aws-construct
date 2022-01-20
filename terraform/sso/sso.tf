module "sso" {
  source = "git::https://github.com/cloudops92/terraform-aws-modules//terraform/sso?ref=2.0"

  for_each = var.permission_sets

  permission_set_name = each.key
  session_duration    = lookup(each.value, "session_duration", "PT2H")

  ## Policies
  managed_policy_arns = lookup(each.value, "managed_policy_arns", [])
  inline_policy       = lookup(each.value, "inline_policy_file_name", null) == null ? null : file("${path.module}/resources/${lookup(each.value, "inline_policy_file_name", null)}")

  users  = lookup(each.value, "users", [])
  groups = lookup(each.value, "groups", [])

  # Tags
  resource_group = var.resource_group
  deployment     = var.deployment
  owner          = var.owner
  env            = var.env
  customer       = var.customer
  email          = var.email
  repo           = var.repo
  module         = var.module
  tags           = var.tags
}