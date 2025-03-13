terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
  }
}

module "s3_backend_terraform" {
  source = "./s3"
  s3_bucket_name = var.s3_bucket_name
}


module "dynamodb_table_backend_terraform" {
  source = "./dynamodb"
  dynamodb_table_name = var.dynamodb_table_name
}