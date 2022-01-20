resource "aws_iam_policy" "iam_policies" {

  name   = replace(title(replace(var.name, "_", " ")), " ", "")
  policy = data.template_file.iam_policy.rendered
  path   = "/"

  tags = local.tags
}