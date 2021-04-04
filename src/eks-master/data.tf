data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.customer]
  }
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Tier = "app"
  }
}