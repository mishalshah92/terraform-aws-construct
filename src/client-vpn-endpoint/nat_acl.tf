locals {
  network_acl = distinct(data.aws_network_acls.subnet_net_acl.ids)
}

//resource "aws_network_acl_rule" "net_acl_egress_rules" {
//
//  count = length(local.network_acl)
//
//  network_acl_id = local.network_acl[count.index]
//  egress         = false
//  rule_number    = (10 + count.index)
//  protocol       = -1
//  rule_action    = "allow"
//  cidr_block     = var.client_cidr_block
//  from_port      = 0
//  to_port        = 0
//}