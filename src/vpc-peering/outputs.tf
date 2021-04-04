output "name" {
  value = local.name
}

output "id" {
  value = module.vpc-peering.id
}

output "status" {
  value = module.vpc-peering.status
}