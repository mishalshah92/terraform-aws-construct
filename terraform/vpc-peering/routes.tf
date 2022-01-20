locals {

  # Flatten requester_routes
  requester_routes = flatten([
    for route_table, cidr_blocks in var.requester_routes : [
      for cidr_block in cidr_blocks : {
        route_table_id = route_table
        cidr_block     = cidr_block
      }
    ]
  ])

  # Flatten accepter_routes
  accepter_routes = flatten([
    for route_table, cidr_blocks in var.accepter_routes : [
      for cidr_block in cidr_blocks : {
        route_table_id = route_table
        cidr_block     = cidr_block
      }
    ]
  ])

}

resource "aws_route" "requester_routes" {

  count = length(local.requester_routes)

  route_table_id            = local.requester_routes[count.index].route_table_id
  destination_cidr_block    = local.requester_routes[count.index].cidr_block
  vpc_peering_connection_id = module.vpc-peering.id

  depends_on = [
    module.vpc-peering
  ]
}

resource "aws_route" "accepter_routes" {

  count = length(local.accepter_routes)

  route_table_id            = local.accepter_routes[count.index].route_table_id
  destination_cidr_block    = local.accepter_routes[count.index].cidr_block
  vpc_peering_connection_id = module.vpc-peering.id

  depends_on = [
    module.vpc-peering
  ]
}