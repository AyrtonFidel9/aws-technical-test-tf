resource "aws_internet_gateway" "terraform_internet_gateway" {
  vpc_id  = var.vpc_id
  tags    = tomap(var.tags) 
}