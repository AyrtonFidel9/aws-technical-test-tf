data "terraform_remote_state" "tf_vpc" {
  backend = "s3"
  config = {
    bucket = "uplinq-infra"
    key = "us-east-1/env/prod/network/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "tf_route_tables" {
  backend = "s3"
  config = {
    bucket = "uplinq-infra"
    key = "us-east-1/env/prod/network/route-tables/terraform.tfstate"
    region = "us-east-1"
  }
}