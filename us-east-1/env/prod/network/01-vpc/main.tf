module "network" {
  source = "../../../../../modules/network/01-vpc"
  
  cidr_block_range = var.cidr_block

  tags = {
    Description         = "VPC for Uplinq project"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}