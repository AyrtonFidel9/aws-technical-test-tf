resource "aws_eks_cluster" "terraform_eks_cluster" {
  name      = "${var.tags.Environment}-${var.tags.Application}-eks-cluster"
  role_arn  = var.eks_iam_role_arn
  
  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_public_access  = true
  }
  
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true

  }
  
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  version = "1.30"

  tags = tomap(var.tags)
  
}

resource "aws_cloudwatch_log_group" "eks_cluster_logs" {
  name              = "/aws/eks/${"${var.tags.Environment}-${var.tags.Application}-eks-cluster"}/cluster"
  retention_in_days = 7
} 

data "tls_certificate" "aws_eks_tls" {
  url = aws_eks_cluster.terraform_eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list    = ["sts.amazonaws.com"]
  thumbprint_list   = [data.tls_certificate.aws_eks_tls.certificates[0].sha1_fingerprint]
  url               = data.tls_certificate.aws_eks_tls.url
}

data "aws_iam_policy_document" "eks_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks_oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks_oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "oidc_eks_role" {
  assume_role_policy = data.aws_iam_policy_document.eks_oidc_assume_role_policy.json
  name = "${var.tags.Environment}-${var.tags.Application}-eks-cluster-service-role"
}

resource "aws_eks_access_entry" "custom_access_entry" {
  cluster_name      = aws_eks_cluster.terraform_eks_cluster.name
  principal_arn     = var.eks_cluster_ae_role_arn
  #kubernetes_groups = [ "system:nodes" ]
  type              = "STANDARD"

}

resource "aws_eks_access_entry" "custom_access_entry_for_pipeline" {
  cluster_name      = aws_eks_cluster.terraform_eks_cluster.name
  principal_arn     = var.ec2_helm_role
  #kubernetes_groups = [ "system:nodes" ]
  type              = "STANDARD"

}

resource "aws_eks_access_policy_association" "AmazonEKSClusterAdminPolicyAssociation" {
  cluster_name  = aws_eks_cluster.terraform_eks_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.eks_cluster_ae_role_arn

  access_scope {
    type       = "cluster"
  }
}

resource "aws_eks_access_policy_association" "AmazonEKSClusterAdminPolicyAssociationToCodeBuild" {
  cluster_name  = aws_eks_cluster.terraform_eks_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.ec2_helm_role

  access_scope {
    type       = "cluster"
  }
}
