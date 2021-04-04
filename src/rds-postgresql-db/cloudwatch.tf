locals {
  cloudwatch_alarm_name_prefix = "${var.resource_group}/rds-postgresql-db/${var.name}"
  alarm_actions_arn            = var.alarm_actions_arn == null ? [data.aws_sns_topic.rg_default.arn] : merge(var.alarm_actions_arn, [data.aws_sns_topic.rg_default.arn])
}

#
# CloudWatch resources
#

resource "aws_cloudwatch_metric_alarm" "rds_cloudwatch_alarms" {

  for_each = var.alerts

  alarm_name          = "${local.cloudwatch_alarm_name_prefix}/${each.key}"
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods

  metric_name = each.value.metric_name
  namespace   = "AWS/RDS"
  period      = each.value.period
  statistic   = each.value.statistic
  threshold   = each.value.threshold

  actions_enabled     = each.value.actions_enabled
  alarm_actions       = local.alarm_actions_arn
  alarm_description   = each.value.alarm_description
  datapoints_to_alarm = each.value.datapoints_to_alarm

  dimensions = {
    DBInstanceIdentifier = module.postgresql.id
  }

  insufficient_data_actions = local.alarm_actions_arn
  ok_actions                = local.alarm_actions_arn
  treat_missing_data        = each.value.treat_missing_data

  tags = local.tags
}

resource "aws_cloudwatch_metric_alarm" "database_cpu_credits" {
  // This results in 1 if instance_type starts with "db.t", 0 otherwise.
  count = substr(var.instance_class, 0, 3) == "db.t" ? 1 : 0

  alarm_name          = "${local.cloudwatch_alarm_name_prefix}/CPUCredtiBalance"
  alarm_description   = "Database CPU credit balance"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUCreditBalance"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.alarm_cpu_credit_balance_threshold

  dimensions = {
    DBInstanceIdentifier = module.postgresql.id
  }

  alarm_actions             = local.alarm_actions_arn
  ok_actions                = local.alarm_actions_arn
  insufficient_data_actions = local.alarm_actions_arn
  tags                      = local.tags
}