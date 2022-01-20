data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "template_file" "role_assume_policy" {

  template = file("${path.module}/policies/${var.name}.json")

  vars = {
    account_id   = data.aws_caller_identity.current.account_id
    iam_username = var.name
  }
}

data "aws_iam_policy" "iam_policies" {
  for_each = toset(var.policies)
  name     = each.key
}