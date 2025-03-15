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

module "eks_permissions" {
  source = "../../../../../modules/eks/01-iam-permissions"
  
  eks_iam_users_arn = var.users_arn

  tags = {
    Description         = "eks iam roles and permissions"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}