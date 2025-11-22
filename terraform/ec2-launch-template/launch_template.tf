resource "aws_security_group" "ec2_sg" {

  count = var.create_sg ? 1 : 0

  description = "Security group for ec2 machine of Service."
  vpc_id      = var.vpc_id

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags = local.tags
}

module "ec2_launch_template" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/ec2-launch-template?ref=0.1"

  name        = var.name
  description = var.description

  vpc_subnet_id = element(tolist(data.aws_subnet_ids.template_subnets.ids), 1)

  ec2_iam_instance_profile_name  = var.iam_instance_profile_name
  ec2_ami_id                     = var.ami_id
  ec2_keypair_name               = var.keypair_name
  ec2_instance_type              = var.instance_type
  ec2_instance_root_volume_size  = var.instance_root_volume_size
  ec2_public                     = var.public
  ec2_security_group_ids         = var.create_sg ? concat([aws_security_group.ec2_sg[0].id], var.security_group_ids) : var.security_group_ids
  ec2_init_config_base64_encode  = var.init_config == null ? var.init_config : base64encode(var.init_config)
  ec2_instance_shutdown_behavior = var.instance_shutdown_behavior
  ec2_disable_api_termination    = true

  # Tags
  customer       = var.customer
  owner          = var.owner
  env            = var.env
  email          = var.email
  repo           = var.repo
  tags           = var.tags
  resource_group = var.resource_group
  deployment     = var.deployment
  module         = var.module
}