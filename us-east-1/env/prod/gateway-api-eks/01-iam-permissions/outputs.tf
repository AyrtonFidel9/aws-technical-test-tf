output "eks_iam_role_arn" {
  description = "eks iam role arn"
  value       = module.eks_permissions.eks_cluster_iam_role_arn
}

output "eks_node_group_iam_role_arn" {
  description = "eks iam role arn"
  value       = module.eks_permissions.eks_node_group_iam_role_arn
}

output "eks_cluster_ae_role_arn" {
  description = "iam role to connect to the EKS ROLE"
  value = module.eks_permissions.eks_cluster_ae_role_arn
}