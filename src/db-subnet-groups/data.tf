data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet_ids" "db_subnets" {

  count = var.is_default_vpc ? 0 : 1

  vpc_id = var.vpc_id
  filter {
    name   = "tag:Tier"
    values = ["db"]
  }
}

data "aws_subnet_ids" "db_subnets_default" {
  vpc_id = var.vpc_id
}