locals {
  sg-name = "${var.resource_group}/vpc/${var.name}"
}

resource "aws_security_group" "vpn_sg" {
  description = "Allow VPN traffic"
  vpc_id      = data.aws_vpc.vpn_vpc.id
  tags = merge(local.tags, {
    Name = local.sg-name
  })
}

resource "aws_security_group_rule" "allow_vpn_traffic" {
  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"
  cidr_blocks = [
    var.client_cidr_block
  ]
  security_group_id = aws_security_group.vpn_sg.id
  description       = "Allow VPN ${var.name} traffic"
}

resource "aws_security_group_rule" "allow_self_traffic" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.vpn_sg.id
  description       = "Allow Self traffic"
}

resource "aws_security_group_rule" "allow_self_egress_traffic" {
  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.vpn_sg.id
  description       = "Allow Self traffic"
}