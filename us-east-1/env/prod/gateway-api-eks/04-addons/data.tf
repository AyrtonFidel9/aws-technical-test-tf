data "terraform_remote_state" "tf_cluster"{
  backend = "s3"
  config = {
    bucket = "uplinq-infra"
    key = "us-east-1/env/prod/gateway-api-eks/cluster/terraform.tfstate"
    region = "us-east-1"
  }
}