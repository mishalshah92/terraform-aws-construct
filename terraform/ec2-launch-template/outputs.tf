output "lt_id" {
  value = module.ec2_launch_template.id
}

output "lt_name" {
  value = module.ec2_launch_template.name
}

output "lt_arn" {
  value = module.ec2_launch_template.arn
}

output "lt_latest_version" {
  value = module.ec2_launch_template.latest_version
}

output "lt_default_version" {
  value = module.ec2_launch_template.default_version
}