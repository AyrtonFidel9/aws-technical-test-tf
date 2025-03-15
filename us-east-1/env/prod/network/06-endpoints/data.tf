data "terraform_remote_state" "tf_vpc" {
  backend = "local"
  config = {
    path = "../01-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "tf_route_tables" {
  backend = "local"
  config = {
    path = "../05-route-tables/terraform.tfstate"
  }
}