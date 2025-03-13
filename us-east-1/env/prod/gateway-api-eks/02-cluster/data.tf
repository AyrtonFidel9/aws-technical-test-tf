data "terraform_remote_state" "tf_iam" {
  backend = "local"
  config = {
    path = "../01-iam-permissions/terraform.tfstate"
  }
}

data "terraform_remote_state" "tf_subnets" {
  backend = "local"
  config = {
    path = "../../network/02-subnets/terraform.tfstate"
  }
}

data "terraform_remote_state" "tf_pipeline_iam" {
  backend = "local"
  config = {
    path = "../../pipeline/terraform.tfstate"
  }
}