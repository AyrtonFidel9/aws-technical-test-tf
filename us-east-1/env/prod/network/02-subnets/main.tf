module "public_subnets" {
  source = "../../../../../modules/network/02-subnets"

  azs           = var.azs
  subnets_type  = "public"
  subnets       = var.public_subnets
  vpc_id        = data.terraform_remote_state.tf_vpc.outputs.vpc_id

  tags = {
    Description         = "Public subnet"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  } 
}

module "pii_sanitizer_subnets" {
  source = "../../../../../modules/network/02-subnets"

  azs             = var.azs
  subnets_type    = "private"
  subnets         = var.pii_sanitizer_subnets
  vpc_id          = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  additional_name = "pii-sanitizer"
  
  tags = {
    Description         = "Private subnets for PII Sanitizer"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  } 
}


module "gateway_api_subnets" {
  source = "../../../../../modules/network/02-subnets"

  azs             = var.azs
  subnets_type    = "private"
  subnets         = var.gateway_api_subnets
  vpc_id          = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  additional_name = "gateway-api-layer"
  
  tags = {
    Description         = "Private subnets for Gateway API Layer"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  } 
}

module "inference_domain_subnets" {
  source = "../../../../../modules/network/02-subnets"

  azs             = var.azs
  subnets_type    = "private"
  subnets         = var.inference_domain_subnets
  vpc_id          = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  additional_name = "inference-domain-layer"
  
  tags = {
    Description         = "Private subnets for Inference domain"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  } 
}


module "isolated_subnets" {
  source = "../../../../../modules/network/02-subnets"

  azs           = var.azs
  subnets_type  = "isolated"
  subnets       = var.isolated_subnets
  vpc_id        = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  
  tags = {
    Description         = " subnet"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  } 
}
