locals {
  sns_topic_name = var.resource_group
}

resource "aws_sns_topic" "resource_group_default" {
  name         = local.sns_topic_name
  display_name = var.resource_group

  # Policy
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF

  tags = local.tags
}

resource "aws_sns_topic_policy" "resource_group_default" {
  arn    = aws_sns_topic.resource_group_default.arn
  policy = data.aws_iam_policy_document.sns_policy.json
}