data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "template_file" "iam_policy" {

  template = file("${path.module}/policies/${var.name}.json")

  vars = {
    account_id = data.aws_caller_identity.current.account_id
  }
}