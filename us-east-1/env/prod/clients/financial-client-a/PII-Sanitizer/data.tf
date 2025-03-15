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

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-08b5b3a93ed654d19"]
  }

  owners = ["137112412989"]
}