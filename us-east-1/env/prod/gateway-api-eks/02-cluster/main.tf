module "eks_cluster" {
  source = "../../../../../modules/eks/02-cluster"

  subnet_ids              = data.terraform_remote_state.tf_subnets.outputs.gateway_api_subnets_id
  eks_iam_role_arn        = data.terraform_remote_state.tf_iam.outputs.eks_iam_role_arn
  eks_cluster_ae_role_arn = data.terraform_remote_state.tf_iam.outputs.eks_cluster_ae_role_arn
  ec2_helm_role           = [for iam_role in data.terraform_remote_state.tf_pipeline_iam.outputs.iam_roles_codebuild_arn : iam_role if (strcontains(iam_role,"helm"))][0]
  
  tags = {
    Description         = "EKS Cluster"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
    CreationDate        = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
}