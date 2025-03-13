resource "aws_iam_role" "tf_cluster_access_entry_role" {
  name = "${var.tags.Environment}-${var.tags.Application}-eks-cluster-access-entry-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        AWS = var.eks_iam_users_arn
      }
    }]
    Version = "2012-10-17"
  })
  tags = tomap(var.tags)
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicyClusterIamRole" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.tf_cluster_access_entry_role.name
}
