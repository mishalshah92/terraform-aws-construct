resource "aws_iam_group" "iam_groups" {
  name = var.name
  path = "/"
}

resource "aws_iam_group_policy_attachment" "iam_groups_policy_attachment" {

  for_each = data.aws_iam_policy.iam_policies

  group      = aws_iam_group.iam_groups.name
  policy_arn = each.value["arn"]
}