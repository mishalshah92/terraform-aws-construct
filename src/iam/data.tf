data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "template_file" "iam_policies" {
  count    = length(var.policies)
  template = file("${path.module}/policies/${element(var.policies, count.index)}.json")

  vars = {
    account_id = data.aws_caller_identity.current.account_id
  }
}