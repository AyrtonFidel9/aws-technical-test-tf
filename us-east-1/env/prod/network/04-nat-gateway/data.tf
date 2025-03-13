data "terraform_remote_state" "tf_subnets" {
  backend = "local"
  config = {
    path = "../02-subnets/terraform.tfstate"
  }
}
