data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy" "iam_policies" {
  for_each = toset(var.policies)
  name     = each.key
}