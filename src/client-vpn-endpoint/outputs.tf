output "id" {
  value = module.client-vpn-endpoint.id
}

output "dns_name" {
  value = module.client-vpn-endpoint.dns_name
}

output "status" {
  value = module.client-vpn-endpoint.status
}

output "log_group_name" {
  value = module.client-vpn-endpoint.log_group_name
}

output "vpn_sg_id" {
  value = aws_security_group.vpn_sg.id
}

output "authorization_rules" {
  value = module.authorization_rules
}

output "vpn_network_associations" {
  value = module.vpn_network_association
}