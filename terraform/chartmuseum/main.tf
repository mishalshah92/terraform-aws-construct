terraform {
  required_version = "> 0.12"

  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  region = var.region
}

locals {
  cname       = var.env == "prod" ? "chartmuseum" : "${var.env}.chartmuseum"
  hostname    = var.env == "prod" ? "${local.cname}.${var.route_53_zone}" : "${local.cname}.${var.route_53_zone}"
  name_prefix = "${var.customer}-chartmuseum-${var.env}"

  default_tags = {
    Customer = var.customer
    Env      = var.env
    Commit   = var.git_commit
    Tool     = var.tool
  }

  tags = merge(local.default_tags, var.tags)
}

resource "aws_route53_record" "dns_record" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = local.cname
  type    = "CNAME"
  ttl     = "5"
  records = [aws_lb.alb.dns_name]
}
