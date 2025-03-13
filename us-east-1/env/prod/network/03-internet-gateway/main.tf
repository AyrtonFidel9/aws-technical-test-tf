module "internet_gateway" {
  source = "../../../../../modules/network/03-internet-gateway"

  vpc_id = data.terraform_remote_state.tf_vpc.outputs.vpc_id

  tags = {
    Name                = "igw-uplinq"
    Description         = "Internet gateway"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  } 
}