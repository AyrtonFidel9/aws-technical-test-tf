data "terraform_remote_state" "tf_vpc" {
  backend = "s3"
  config = {
    bucket = "uplinq-infra"
    key = "us-east-1/env/prod/network/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}