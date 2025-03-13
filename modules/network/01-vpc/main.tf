resource "aws_vpc" "vpc_eks" {
  cidr_block            = var.cidr_block_range
  enable_dns_hostnames  = true
  enable_dns_support    = true
  tags                  = merge({
    Name = "${var.tags.Application}-${var.tags.Environment}-vpc"
  }, var.tags)
}