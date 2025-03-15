data "terraform_remote_state" "tf_vpc" {
  backend = "local"
  config = {
    path = "../../../network/01-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "tf_subnets" {
  backend = "local"
  config = {
    path = "../../../network/02-subnets/terraform.tfstate"
  }
}