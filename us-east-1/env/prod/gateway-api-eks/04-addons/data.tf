data "terraform_remote_state" "tf_cluster"{
  backend = "local"
  config = {
    path = "../02-cluster/terraform.tfstate"
  }
}