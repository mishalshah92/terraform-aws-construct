data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "template_file" "user_default_policy" {
  count    = length(local.users)
  template = file("${path.module}/policies/user_default_policy.json")

  vars = {
    account_id   = data.aws_caller_identity.current.account_id
    iam_username = local.users[count.index]
  }
}