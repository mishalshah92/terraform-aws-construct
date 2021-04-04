
output "cluster_id" {
  value = module.eks-cluster-master.cluster_id
}

output "cluster_sg_id" {
  value = module.eks-cluster-master.cluster_sg_id
}

output "eks_command" {
  value = module.eks-cluster-master.eks_command
}

output "kubeconfig" {
  value = module.eks-cluster-master.kubeconfig
}