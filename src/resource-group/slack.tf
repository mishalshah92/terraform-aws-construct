resource "aws_kms_ciphertext" "slack_url" {
  plaintext = var.slack_webhook_url
  key_id    = module.rg_kms_key.key_arn
}

module "notify_slack" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "~> 4.0"

  lambda_function_name = "${module.resource_group.name}_slack-notifier"
  lambda_description   = "This function notify cloudwatch alerts to slack channel."

  cloudwatch_log_group_retention_in_days = var.slack_cloudwatch_log_group_retention_in_days

  create_sns_topic = false
  sns_topic_name   = aws_sns_topic.resource_group_default.name

  slack_webhook_url = aws_kms_ciphertext.slack_url.ciphertext_blob
  slack_channel     = var.slack_channel
  slack_username    = module.resource_group.name

  kms_key_arn = module.rg_kms_key.key_arn


  tags = merge({
    Name = "${module.resource_group.name}_slack-notifier"
  }, local.tags)


  depends_on = [
    aws_sns_topic.resource_group_default
  ]
}