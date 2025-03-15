data "terraform_remote_state" "tf_vpc" {
  backend = "s3"
  config = {
    bucket = "uplinq-infra"
    key = "us-east-1/env/prod/network/vpc/terraform.tfstate"
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

data "terraform_remote_state" "tf_igw" {
  backend = "s3"
  config = {
    bucket = "uplinq-infra"
    key = "us-east-1/env/prod/network/igw/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "tf_nat" {
  backend = "s3"
  config = {
    bucket = "uplinq-infra"
    key = "us-east-1/env/prod/network/nat-gateway/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_subnet" "public" {
  count = length(
    data.terraform_remote_state.tf_subnets.outputs.public_subnets_id
  )
  id = tolist(data.terraform_remote_state.tf_subnets.outputs.public_subnets_id)[count.index]
}

data "aws_subnet" "pii_sanitizer" {
  count = length(
    data.terraform_remote_state.tf_subnets.outputs.pii_sanitizer_subnets_id
  )
  id = tolist(data.terraform_remote_state.tf_subnets.outputs.pii_sanitizer_subnets_id)[count.index]
}

data "aws_subnet" "gateway_api" {
  count = length(
    data.terraform_remote_state.tf_subnets.outputs.gateway_api_subnets_id
  )
  id = tolist(data.terraform_remote_state.tf_subnets.outputs.gateway_api_subnets_id)[count.index]
}

data "aws_subnet" "inference_domain" {
  count = length(
    data.terraform_remote_state.tf_subnets.outputs.inference_domain_subnets_id
  )
  id = tolist(data.terraform_remote_state.tf_subnets.outputs.inference_domain_subnets_id)[count.index]
}

data "aws_subnet" "isolated" {
  count = length(
    data.terraform_remote_state.tf_subnets.outputs.isolated_subnets_id
  )
  id = tolist(data.terraform_remote_state.tf_subnets.outputs.isolated_subnets_id)[count.index]
}