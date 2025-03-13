module "public_route_tables" {
  source = "../../../../../modules/network/05-route-tables"
  
  internet_gateway_id  = data.terraform_remote_state.tf_igw.outputs.igw_id
  subnets              = data.aws_subnet.public
  vpc_id               = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  type                 = "public"

  tags = {
    Description         = "Public Route tables"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}

module "pii_sanitizer_route_tables" {
  source = "../../../../../modules/network/05-route-tables"
  
  nat_gateways_id      = data.terraform_remote_state.tf_nat.outputs.nat_gateways_id
  subnets              = data.aws_subnet.pii_sanitizer
  vpc_id               = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  type                 = "private"
  additional_name      = "pii-sanitizer"

  tags = {
    Description         = "pii_sanitizer Private Route tables"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}

module "gateway_api_route_tables" {
  source = "../../../../../modules/network/05-route-tables"
  
  nat_gateways_id      = data.terraform_remote_state.tf_nat.outputs.nat_gateways_id
  subnets              = data.aws_subnet.gateway_api 
  vpc_id               = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  type                 = "private"
  additional_name      = "gateway-api"

  tags = {
    Description         = "gateway-api Private Route tables"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}

module "inference_domain_route_tables" {
  source = "../../../../../modules/network/05-route-tables"
  
  nat_gateways_id      = data.terraform_remote_state.tf_nat.outputs.nat_gateways_id
  subnets              = data.aws_subnet.inference_domain
  vpc_id               = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  type                 = "private"
  additional_name      = "inference-domain"

  tags = {
    Description         = "inference-domain Private Route tables"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}

module "isolated_route_tables" {
  source = "../../../../../modules/network/05-route-tables"
  
  subnets              = data.aws_subnet.isolated
  vpc_id               = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  type                 = "isolated"

  tags = {
    Description         = "Isolated Route tables"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}



