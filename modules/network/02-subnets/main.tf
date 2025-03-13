resource "aws_subnet" "terraform_vpc_subnets" {
  count = length(var.azs)

  vpc_id              = var.vpc_id
  cidr_block          = var.subnets[count.index]
  availability_zone   = var.azs[count.index]

  tags = merge({
    Name = var.additional_name == "no-name" ? "${var.tags.Environment}-${var.subnets_type}-${count.index+1}" : "${var.additional_name}-${var.tags.Environment}-${var.subnets_type}-${count.index+1}",
  }, var.tags)
}