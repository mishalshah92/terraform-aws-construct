resource "aws_security_group" "redis_sg" {
  description = "Allow Redis traffic."
  vpc_id      = data.aws_vpc.selected.id
  tags = merge(local.tags, {
    Name          = "${var.resource_group}/elasticache/${var.name}"
    REDIS         = local.redis_name
    REDIS_DEFAULT = "true"
  })
}

resource "aws_security_group_rule" "allow_self_traffic" {
  type              = "ingress"
  from_port         = var.redis_port
  to_port           = var.redis_port
  protocol          = "tcp"
  self              = true
  security_group_id = aws_security_group.redis_sg.id
  description       = "Allow Self traffic on ${var.redis_port}"
}

resource "aws_security_group_rule" "allow_self_egress_traffic" {
  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.redis_sg.id
  description       = "Allow Self traffic"
}

resource "aws_security_group_rule" "allow_sg_traffic" {

  for_each = toset(var.allow_sg_ids)

  type                     = "ingress"
  from_port                = var.redis_port
  to_port                  = var.redis_port
  protocol                 = "tcp"
  source_security_group_id = each.key
  security_group_id        = aws_security_group.redis_sg.id
  description              = "Allow traffic from ${each.key}"
}