module "eks_addons" {
  source = "../../../../modules/eks/04-add-ons"
  
  cluster_name  = data.terraform_remote_state.tf_cluster.outputs.cluster_name
  addons        = var.addons
  openid_arn    = data.terraform_remote_state.tf_cluster.outputs.openid_arn
  openid_url    = data.terraform_remote_state.tf_cluster.outputs.openid_url 
  
  tags = {
    Description         = "EKS Cluster Addons"
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