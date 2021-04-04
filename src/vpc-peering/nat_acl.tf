locals {

  # Flatten requester_routes
  requester_acls = flatten([
    for nat_id, cidr_blocks in var.requester_acl : [
      for cidr_block in cidr_blocks : {
        nat_id     = nat_id
        cidr_block = cidr_block
      }
    ]
  ])

  # Flatten accepter_routes
  accepter_acls = flatten([
    for nat_id, cidr_blocks in var.accepter_acl : [
      for cidr_block in cidr_blocks : {
        nat_id     = nat_id
        cidr_block = cidr_block
      }
    ]
  ])

}

resource "aws_network_acl_rule" "requnet_acl_egress_rules" {

  count = length(local.requester_acls)

  network_acl_id = local.requester_acls[count.index].nat_id
  egress         = false
  rule_number    = (10 + count.index)
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = local.requester_acls[count.index].cidr_block
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "accepter_acl_egress_rules" {

  count = length(local.accepter_acls)

  network_acl_id = local.accepter_acls[count.index].nat_id
  egress         = false
  rule_number    = (10 + count.index)
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = local.accepter_acls[count.index].cidr_block
  from_port      = 0
  to_port        = 0
}