terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
  }

  backend "s3" {
    
  }
}

module "network" {
  source = "../../../../../modules/network/01-vpc"
  
  cidr_block_range = var.cidr_block

  tags = {
    Description         = "VPC for Uplinq project"
    Environment         = var.e vironment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}