resource "aws_key_pair" "eks_node_keypair" {

  key_name   = "${var.node_group_name}-eks"
  public_key = file("${path.module}/keypair/${var.node_ssh_keypair_name}.pub")
  tags       = local.tags
}

module "eks-node-group" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/eks-node-group?ref=0.1"

  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_labels     = var.node_labels

  # configs
  instance_types     = var.instance_types
  instance_disk_size = var.instance_disk_size
  ami_type           = var.ami_type

  # Remote access
  node_ssh_sg_ids       = concat([data.aws_security_group.default.id], var.node_ssh_sg_ids)
  node_ssh_keypair_name = aws_key_pair.eks_node_keypair.key_name


  # Scaling
  scaling_desiered_size = var.scaling_desiered_size
  scaling_max_size      = var.scaling_max_size
  scaling_min_size      = var.scaling_min_size

  # network
  node_vpc_id  = data.aws_vpc.vpc.id
  node_subnets = data.aws_subnet_ids.subnets.ids

  # Tags
  owner      = var.owner
  env        = var.env
  customer   = var.customer
  email      = var.email
  git_commit = var.git_commit
  repo       = var.repo
  tags       = var.tags

  depends_on = [
    aws_key_pair.eks_node_keypair
  ]
}

//resource "aws_security_group_rule" "allow-local-access" {
//  description       = "Allow node to communicate from VPN"
//  type              = "ingress"
//  from_port         = 0
//  to_port           = 65535
//  protocol          = "tcp"
//  cidr_blocks       = var.public_access_cidrs
//  security_group_id = module.eks-node-group.node_sg_id
//}