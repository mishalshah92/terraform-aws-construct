locals {

  group_policies = flatten([
    for group, policy_list in var.groups : [
      for policy in var.groups[group] : {
        group      = group
        policy_arn = policy
      }
    ]
  ])

}

resource "aws_iam_group" "iam_groups" {
  for_each = var.groups
  name     = each.key
  path     = "/"
}

resource "aws_iam_group_policy_attachment" "iam_groups_policy_attachment" {

  count = length(local.group_policies)

  group      = local.group_policies[count.index].group
  policy_arn = substr(local.group_policies[count.index].policy_arn, 0, 3) == "arn" ? local.group_policies[count.index].policy_arn : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${local.group_policies[count.index].policy_arn}"

  depends_on = [
    aws_iam_group.iam_groups,
  ]
}