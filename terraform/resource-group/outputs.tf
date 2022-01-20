output "resource_group_arn" {
  value = module.resource_group.arn
}

output "alert_sns_topic" {
  value = aws_sns_topic.resource_group_default.name
}

output "alert_sns_arn" {
  value = aws_sns_topic.resource_group_default.arn
}

output "notify_slack_lambda_function_name" {
  value = module.notify_slack.notify_slack_lambda_function_name
}

output "notify_slack_lambda_iam_role_arn" {
  value = module.notify_slack.lambda_iam_role_arn
}

output "notify_slack_lambda_cloudwatch_log_group_arn" {
  value = module.notify_slack.lambda_cloudwatch_log_group_arn
}