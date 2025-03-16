module "rds" {
  source = "../../../../modules/rds"

  db_type              = var.db_type
  storage              = var.storage
  engine               = var.engine
  engine_version       = var.engine_version
  parameter_group_family = var.parameter_group_family
  username             = var.username
  ingress_subnets_cidr = data.terraform_remote_state.tf_subnets.outputs.gateway_api_subnets_cidr
  subnets_id           = data.terraform_remote_state.tf_subnets.outputs.isolated_subnets_id
  port                 = var.port 
  vpc_id               = data.terraform_remote_state.tf_vpc.outputs.vpc_id 

  tags = {
    Description         = "Database"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}