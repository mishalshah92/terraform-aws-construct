locals {
  cloudwatch_alarm_name_prefix = "${var.resource_group}/redis-elasticache/${var.name}"
  alarm_actions_arn            = var.alarm_actions_arn == null ? [data.aws_sns_topic.rg_default.arn] : merge(var.alarm_actions_arn, [data.aws_sns_topic.rg_default.arn])
}

#
# CloudWatch resources
#

resource "aws_cloudwatch_metric_alarm" "redis_cloudwatch_alarms_001" {

  for_each = var.alerts

  alarm_name          = "${local.cloudwatch_alarm_name_prefix}/001/${each.key}"
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods

  metric_name = each.value.metric_name
  namespace   = "AWS/ElastiCache"
  period      = each.value.period
  statistic   = each.value.statistic
  threshold   = each.value.threshold

  actions_enabled     = each.value.actions_enabled
  alarm_actions       = local.alarm_actions_arn
  alarm_description   = each.value.alarm_description
  datapoints_to_alarm = each.value.datapoints_to_alarm

  dimensions = {
    CacheClusterId = element(tolist(module.redis-elasticache.member_clusters), 1)
  }

  insufficient_data_actions = local.alarm_actions_arn
  ok_actions                = local.alarm_actions_arn
  treat_missing_data        = each.value.treat_missing_data

  tags = local.tags
}

resource "aws_cloudwatch_metric_alarm" "redis_cloudwatch_alarms_002" {

  for_each = var.alerts

  alarm_name          = "${local.cloudwatch_alarm_name_prefix}/002/${each.key}"
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods

  metric_name = each.value.metric_name
  namespace   = "AWS/ElastiCache"
  period      = each.value.period
  statistic   = each.value.statistic
  threshold   = each.value.threshold

  actions_enabled     = each.value.actions_enabled
  alarm_actions       = local.alarm_actions_arn
  alarm_description   = each.value.alarm_description
  datapoints_to_alarm = each.value.datapoints_to_alarm

  dimensions = {
    CacheClusterId = element(tolist(module.redis-elasticache.member_clusters), 2)
  }

  insufficient_data_actions = local.alarm_actions_arn
  ok_actions                = local.alarm_actions_arn
  treat_missing_data        = each.value.treat_missing_data

  tags = local.tags
}