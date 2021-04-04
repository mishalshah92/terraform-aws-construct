data "aws_region" "current" {}

data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "gsuite_saml_assume_policy" {
  statement {
    actions = [
      "sts:AssumeRoleWithSAML"
    ]

    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:saml-provider/Gsuite"
      ]
    }

    condition {
      test = "StringEquals"
      values = [
        "https://signin.aws.amazon.com/saml"
      ]
      variable = "SAML:aud"
    }
  }
}


data "aws_iam_policy_document" "ec2_assume_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}