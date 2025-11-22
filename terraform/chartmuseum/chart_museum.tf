data "template_file" "chart_museum_docker_compose" {
  template = file("${path.module}/configs/chart_museum.yml")

  vars = {
    aws_region                    = data.aws_region.current.id
    chart_museum_s3_bucket        = var.chart_museum_bucket
    chart_museum_s3_bucket_region = var.chart_museum_bucket_region
    port                          = var.chart_museum_service_port
    tag                           = var.chart_museum_docker_image_tag
  }
}

data "aws_iam_policy_document" "chart_museum" {
  statement {
    sid = "1"

    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${var.chart_museum_bucket}/*"
    ]
  }

  statement {
    sid = "2"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "*"
    ]
  }
}

module "chart_museum_service" {
  source = "git::https://github.com/cloudops92/terraform-aws-base-modules.git//src/ec2-microservice"

  # service
  service_docker_compose_content = data.template_file.chart_museum_docker_compose.rendered
  service_port                   = var.chart_museum_service_port

  # configurations
  ec2_ami_id                   = var.app_ami_id
  ec2_iam_policy_json          = data.aws_iam_policy_document.chart_museum.json
  ec2_instance_type            = var.ec2_instance_type
  ec2_keypair_name             = var.keypair_name
  ec2_public                   = true
  asg_max_size                 = var.chart_museum_max_instances
  asg_min_size                 = var.chart_museum_min_instances
  asg_desired_capacity         = var.chart_museum_desired_instances
  tg_healthcheck_response_code = var.chart_museum_health_check_response_code
  tg_healthcheck_path          = var.chart_museum_health_check_path

  # network
  vpc_id         = var.vpc_id
  vpc_subnet_ids = data.aws_subnet_ids.subnets.ids

  # Tags
  customer = var.customer
  service  = "chartmuseum"
  env      = var.env
  commit   = var.git_commit
  tags     = var.tags
}

# Security Group Rules

resource "aws_security_group_rule" "chart_museum_service" {
  security_group_id        = module.chart_museum_service.service_instance_sg_id
  type                     = "ingress"
  from_port                = var.chart_museum_service_port
  to_port                  = var.chart_museum_service_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "chart_museum_service_local_access" {
  security_group_id = module.chart_museum_service.service_instance_sg_id
  type              = "ingress"
  from_port         = 0
  to_port           = 65534
  protocol          = "tcp"
  cidr_blocks = [
    var.vpn_cidr
  ]
}

# ALB Scaling Policy
resource "aws_autoscaling_policy" "chart_museum_service_scaling_policy" {
  name                      = "${local.name_prefix}-dynamic-backend-scale-out"
  autoscaling_group_name    = module.chart_museum_service.service_asg_name
  metric_aggregation_type   = "Average"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = "60"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80.0
  }
}