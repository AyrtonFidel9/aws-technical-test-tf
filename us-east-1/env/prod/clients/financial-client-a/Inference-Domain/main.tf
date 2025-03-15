module "financial-client-a-dynamodb" {
  source = "../../../../../../modules/dynamodb"
  
  attributes = var.attributes
  hash_key   = var.hash_key
  range_key  = var.range_key

  tags = {
    Description         = "Dynamo DB table for client  A"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}

module "financial-client-a-s3" {
  source = "../../../../../../modules/s3-buckets"

  tags = {
    Description         = "Dynamo DB table for client A"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}

module "financial-client-a-lambda" {
  source = "../../../../../../modules/lambda"

  cidr_blocks        = data.terraform_remote_state.tf_subnets.outputs.inference_domain_subnets_cidr
  dynamodb_table_arn = module.financial-client-a-dynamodb.dynamodb_table.arn
  s3_bucket_arn      = module.financial-client-a-s3.bucket_info.arn
  subnets_id         = data.terraform_remote_state.tf_subnets.outputs.inference_domain_subnets_id
  vpc_id             = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  filename           = var.filename
  runtime            = var.runtime 

  tags = {
    Description         = "Dynamo DB table for client A"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}
