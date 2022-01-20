resource "aws_iam_user" "iam_users" {
  name = var.name

  tags = merge(local.tags, {
    owner = var.name
  })
}


resource "aws_iam_user_group_membership" "iam_users_group_member" {

  user   = var.name
  groups = var.groups

  depends_on = [
    aws_iam_user.iam_users
  ]
}

resource "aws_iam_user_policy" "iam_users_policy" {
  name   = "default-user-policy"
  user   = aws_iam_user.iam_users.name
  policy = data.template_file.user_default_policy.rendered
}

resource "aws_iam_user_policy_attachment" "attach" {

  for_each = data.aws_iam_policy.iam_policies

  user       = aws_iam_user.iam_users.name
  policy_arn = each.value["arn"]
}