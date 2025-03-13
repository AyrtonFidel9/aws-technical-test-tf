data "terraform_remote_state" "tf_vpc" {
  backend = "local"
  config = {
    path = "../01-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "tf_subnets" {
  backend = "local"
  config = {
    path = "../02-subnets/terraform.tfstate"
  }
}

data "terraform_remote_state" "tf_igw" {
  backend = "local"
  config = {
    path = "../03-internet-gateway/terraform.tfstate"
  }
}

data "terraform_remote_state" "tf_nat" {
  backend = "local"
  config = {
    path = "../04-nat-gateway/terraform.tfstate"
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