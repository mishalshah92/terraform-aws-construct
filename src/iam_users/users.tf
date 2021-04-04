locals {
  users = keys(var.users)
}

resource "aws_iam_user" "iam_users" {
  for_each = var.users
  name     = each.key

  tags = merge(local.tags, {
    owner = each.key
  })
}


resource "aws_iam_user_group_membership" "iam_users_group_member" {

  for_each = var.users

  user   = each.key
  groups = tolist(var.users[each.key].groups)

  permissions_boundary = data.template_file.user_default_policy[count.index].rendered

  depends_on = [
    aws_iam_user.iam_users
  ]
}

//resource "aws_iam_user_policy" "iam_users_policy" {
//
//  count = length(local.users)
//
//  user   = local.users[count.index]
//  policy = data.template_file.user_default_policy[count.index].rendered
//}