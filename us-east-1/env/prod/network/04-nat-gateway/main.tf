module "nat_gateway" {
  source = "../../../../../modules/network/04-nat-gateway"
  
  azs                   = var.azs
  subnet_allocation_ids = data.terraform_remote_state.tf_subnets.outputs.public_subnets_id

  tags = {
    Description         = "Nat gateway"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  } 
}