data "terraform_remote_state" "tf_vpc" {
  backend = "local"
  config = {
    path = "../01-vpc/terraform.tfstate"
  }
}