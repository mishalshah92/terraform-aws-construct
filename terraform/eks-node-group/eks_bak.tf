//locals {
//
//  clusters = keys(var.node_groups)
//
//  node_groups = flatten([
//    for cluster, node_groups in var.node_groups : [
//      for node_group in var.node_groups[cluster] : {
//        cluster    = cluster
//        node_group = node_group
//      }
//    ]
//  ])
//
//  node_keypairs = flatten([
//    for cluster, node_groups in var.node_groups : [
//      for node_group in var.node_groups[cluster] : {
//        name    = node_group.node_group_name
//        keypair = node_group.node_ssh_keypair_name
//      }
//    ]
//  ])
//
//}
//
//resource "aws_key_pair" "eks_node_keypair" {
//  count = length(local.node_keypairs)
//
//  key_name   = "${local.node_keypairs[count.index].name}-eks"
//  public_key = file("${path.module}/keypair/${local.node_keypairs[count.index].keypair}.pub")
//  tags       = local.tags
//}
//
//module "eks-node-group" {
//  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/eks-node-group?ref=mishal/add-eks"
//
//  count = length(local.node_groups)
//
//  cluster_name    = local.node_groups[count.index].cluster
//  node_group_name = local.node_groups[count.index].node_group.node_group_name
//  node_labels     = local.node_groups[count.index].node_group.node_labels
//
//  # configs
//  instance_types        = local.node_groups[count.index].node_group.instance_types
//  instance_disk_size    = local.node_groups[count.index].node_group.instance_disk_size
//  ami_type              = local.node_groups[count.index].node_group.ami_type
//  node_ssh_keypair_name = "${local.node_keypairs[count.index].name}-eks"
//
//  # Scaling
//  scaling_desiered_size = local.node_groups[count.index].node_group.scaling_desiered_size
//  scaling_max_size      = local.node_groups[count.index].node_group.scaling_max_size
//  scaling_min_size      = local.node_groups[count.index].node_group.scaling_min_size
//
//  # network
//  node_vpc_id  = data.aws_vpc.vpc.id
//  node_subnets = data.aws_subnet_ids.subnets.ids
//
//  # Tags
//  owner      = var.owner
//  env        = var.env
//  customer   = var.customer
//  email      = var.email
//  git_commit = var.git_commit
//  repo       = var.repo
//  tags       = var.tags
//
//  depends_on = [
//    aws_key_pair.eks_node_keypair
//  ]
//}
//
////resource "aws_security_group_rule" "allow-local-access" {
////  description       = "Allow node to communicate from VPN"
////  type              = "ingress"
////  from_port         = 0
////  to_port           = 65535
////  protocol          = "tcp"
////  cidr_blocks       = var.public_access_cidrs
////  security_group_id = module.eks-node-group.node_sg_id
////}