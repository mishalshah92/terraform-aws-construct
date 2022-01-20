resource "aws_iam_role" "iam_role" {

  name                  = var.name
  path                  = "/"
  assume_role_policy    = data.template_file.role_assume_policy.rendered
  max_session_duration  = var.max_session_duration
  force_detach_policies = true
  description           = "The role is created using Terraform"
  tags                  = local.tags

  lifecycle {
    create_before_destroy = false
  }

}

resource "aws_iam_role_policy_attachment" "iam_roles_policy_attachments_admin" {

  for_each = data.aws_iam_policy.iam_policies

  role       = aws_iam_role.iam_role.name
  policy_arn = each.value["arn"]
}

resource "aws_iam_instance_profile" "iam_role_instance_profiles" {

  count = var.instance_profile ? 1 : 0

  name = aws_iam_role.iam_role.name
  role = aws_iam_role.iam_role.name
}