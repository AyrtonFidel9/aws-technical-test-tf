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

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-08b5b3a93ed654d19"]
  }

  owners = ["137112412989"]
}