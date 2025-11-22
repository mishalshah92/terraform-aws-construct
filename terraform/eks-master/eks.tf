module "eks-cluster-master" {
  source = "git::https://github.com/mishalshah92/terraform-aws-core-modules.git//src/eks-master?ref=0.1"

  cluster_name            = var.name
  cluster_vpc_id          = data.aws_vpc.vpc.id
  cluster_subnets         = data.aws_subnet_ids.subnets.ids
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  public_access_cidrs     = var.public_access_cidrs
  cluster_version         = var.cluster_version
  log_retention_in_days   = var.log_retention_in_days

  # Tags
  owner      = var.owner
  env        = var.env
  customer   = var.customer
  email      = var.email
  git_commit = var.git_commit
  repo       = var.repo
  tags       = var.tags
}

//resource "aws_security_group_rule" "allow-local-access" {
//  description       = "Allow node to communicate from local"
//  type              = "ingress"
//  from_port         = 0
//  to_port           = 65535
//  protocol          = "tcp"
//  cidr_blocks       = var.public_access_cidrs
//  security_group_id = module.eks-cluster-master.master_sg_id
//}