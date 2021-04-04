resource "aws_iam_policy" "iam_policies" {

  count = length(data.template_file.iam_policies)

  name   = replace(title(replace(element(var.policies, count.index), "_", " ")), " ", "")
  policy = data.template_file.iam_policies[count.index].rendered
  path   = "/"
}