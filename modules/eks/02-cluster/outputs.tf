output "eks_cluster_id" {
  value = aws_eks_cluster.terraform_eks_cluster.id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.terraform_eks_cluster.name
}


output "endpoint" {
  value = aws_eks_cluster.terraform_eks_cluster.endpoint
}

output "openid_arn" {
  value = aws_iam_openid_connect_provider.eks_oidc.arn
}

output "openid_url" {
  value = aws_iam_openid_connect_provider.eks_oidc.url
}
