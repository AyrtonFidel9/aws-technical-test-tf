module "eks_node_groups" {
  source = "../../../../../modules/eks/03-cluster-node-group"

  node_groups             = var.node_groups
  subnet_ids              = data.terraform_remote_state.tf_subnets.outputs.gateway_api_subnets_id
  cluster_name            = data.terraform_remote_state.tf_cluster.outputs.cluster_name
  node_group_iam_role_arn = data.terraform_remote_state.tf_iam.outputs.eks_node_group_iam_role_arn

  tags = {
    Description         = "EKS Node Group"
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