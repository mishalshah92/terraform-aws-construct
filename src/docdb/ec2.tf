resource "aws_security_group" "docdb_sg" {
  description = "DocDB sg to manage traffic."
  vpc_id      = data.aws_db_subnet_group.database.vpc_id

  tags = merge(local.tags, {
    Name          = "${var.resource_group}/docdb/${var.name}"
    DocDB         = local.db_name
    DocDB_DEFAULT = "true"
  })
}

resource "aws_security_group_rule" "allow_self_traffic" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  self              = true
  security_group_id = aws_security_group.docdb_sg.id
  description       = "Allow self traffic on ${var.port}"
}

resource "aws_security_group_rule" "allow_self_egress_traffic" {
  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.docdb_sg.id
  description       = "Allow all egress traffic."
}

resource "aws_security_group_rule" "allowed_sg_traffic" {

  for_each = toset(var.allow_sg_ids)

  type                     = "ingress"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  source_security_group_id = each.value
  security_group_id        = aws_security_group.docdb_sg.id
  description              = "Allow traffic from ${each.key}"
}