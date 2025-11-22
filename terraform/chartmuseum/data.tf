data "aws_caller_identity" "self" {}

data "aws_region" "current" {}

data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id
}

data "aws_route53_zone" "route53_zone" {
  name = var.route_53_zone
}