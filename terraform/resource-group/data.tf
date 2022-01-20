locals {
  kms_root   = tolist(["arn:aws:iam::${data.aws_caller_identity.selected.account_id}:root"])
  kms_admins = var.kms_admin_arn == null ? local.kms_root : concat(local.kms_root, var.kms_admin_arn)
}

data "aws_caller_identity" "selected" {}

data "aws_iam_policy_document" "sns_policy" {

  statement {

    sid = "Policy1"
    principals {
      identifiers = [
        "*"
      ]
      type = "AWS"
    }

    actions = [
      "SNS:Publish",
      "SNS:RemovePermission",
      "SNS:SetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:Receive",
      "SNS:AddPermission",
      "SNS:Subscribe"
    ]

    resources = [
      aws_sns_topic.resource_group_default.arn
    ]

    condition {
      test = "StringEquals"
      values = [
        data.aws_caller_identity.selected.account_id
      ]
      variable = "AWS:SourceOwner"
    }
  }

  statement {

    sid = "Policy2"

    principals {
      identifiers = [
        "*"
      ]
      type = "AWS"
    }

    actions = [
      "SNS:Subscribe",
      "SNS:Receive"
    ]

    resources = [
      aws_sns_topic.resource_group_default.arn
    ]

    condition {
      test = "StringLike"
      values = [
        "*@example.ai"
      ]
      variable = "SNS:Endpoint"
    }
  }
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

    sid = "AllowEncryptDecrypt"

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
