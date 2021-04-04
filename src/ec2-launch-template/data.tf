data "aws_caller_identity" "current" {}

data "aws_vpc" "template_vpc" {
  id = var.vpc_id
}

data "aws_subnet_ids" "template_subnets" {
  vpc_id = var.vpc_id

  tags = {
    Tier = var.subnet_tier
  }

}

data "aws_iam_policy_document" "ec2_instance_role_assume_policy" {
  statement {

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}