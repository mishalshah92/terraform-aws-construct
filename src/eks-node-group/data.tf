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

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "default"
  tags = {
    Name = "${var.customer}-default"
    vpc  = data.aws_vpc.vpc.id
  }
}