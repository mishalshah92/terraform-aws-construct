locals {

  roles = keys(var.roles)

  assume_policies = {
    "gsuite" = data.aws_iam_policy_document.gsuite_saml_assume_policy.json
    "ec2"    = data.aws_iam_policy_document.ec2_assume_policy.json
  }

  role_policies = flatten([
    for role, policy_list in var.role_policies : [
      for policy in var.role_policies[role] : {
        role   = role
        policy = policy
      }
    ]
  ])

}

resource "aws_iam_role" "iam_roles" {

  count = length(local.roles)

  name                  = local.roles[count.index]
  path                  = "/"
  assume_role_policy    = lookup(local.assume_policies, lookup(var.roles, local.roles[count.index]).trust)
  max_session_duration  = lookup(var.roles, local.roles[count.index]).max_session_duration
  force_detach_policies = true
  description           = "The role is created using Terraform"
  tags                  = local.tags

  lifecycle {
    create_before_destroy = false
  }

}

resource "aws_iam_role_policy_attachment" "iam_roles_policy_attachments_admin" {

  count = length(local.role_policies)

  role       = local.role_policies[count.index].role
  policy_arn = substr(local.role_policies[count.index].policy, 0, 3) == "arn" ? local.role_policies[count.index].policy : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${local.role_policies[count.index].policy}"

  depends_on = [
    aws_iam_role.iam_roles
  ]
}

resource "aws_iam_instance_profile" "iam_role_instance_profiles" {

  for_each = toset(var.role_instance_profiles)

  name = each.key
  role = each.key

  depends_on = [
    aws_iam_role.iam_roles
  ]
}