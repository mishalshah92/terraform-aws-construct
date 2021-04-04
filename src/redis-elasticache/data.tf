locals {
  kms_root   = tolist(["arn:aws:iam::${data.aws_caller_identity.selected.account_id}:root"])
  kms_admins = var.kms_admin_arn == null ? local.kms_root : concat(local.kms_root, var.kms_admin_arn)
}

data "aws_caller_identity" "selected" {}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

# https://aws.amazon.com/premiumsupport/knowledge-center/update-key-policy-future/
data "aws_iam_policy_document" "kms_policy_document_admin" {
  statement {

    sid = "AllowAdmin"

    effect = "Allow"

    principals {
      identifiers = local.kms_admins
      type        = "AWS"
    }

    actions = [
      "kms:*",
    ]

    resources = [
      "*",
    ]
  }

  statement {

    sid = "AllowRDS"

    effect = "Allow"

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:DescribeKey"
    ]

    resources = [
      "*",
    ]

    condition {
      test = "StringEquals"
      values = [
        data.aws_caller_identity.selected.account_id
      ]
      variable = "kms:CallerAccount"
    }

    condition {
      test = "StringEquals"
      values = [
        "rds.${var.region}.amazonaws.com"
      ]
      variable = "kms:ViaService"
    }

  }


  statement {

    sid = "AllowDev"

    effect = "Allow"

    principals {
      identifiers = var.kms_dev_arn
      type        = "AWS"
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = [
      "*",
    ]

    condition {
      test = "StringEquals"
      values = [
        data.aws_caller_identity.selected.account_id
      ]
      variable = "kms:CallerAccount"
    }

  }
}

data "aws_sns_topic" "rg_default" {
  name = var.resource_group
}