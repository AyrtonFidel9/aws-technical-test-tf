output "cluster_name" {
  value = module.eks_cluster.eks_cluster_name
}

output "openid_arn" {
  value = module.eks_cluster.openid_arn
}

output "openid_url" {
  value = module.eks_cluster.openid_url
}