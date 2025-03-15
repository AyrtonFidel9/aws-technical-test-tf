data "terraform_remote_state" "tf_iam" {
  backend = "s3"
  config = {
    bucket = "uplinq-infra"
    key = "us-east-1/env/prod/gateway-api-eks/iam-permissions/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "tf_subnets" {
  backend = "s3"
  config = {
    bucket = "uplinq-infra"
    key = "us-east-1/env/prod/network/subnets/terraform.tfstate"
    region = "us-east-1"
  }
}