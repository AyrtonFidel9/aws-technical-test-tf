resource "aws_eip" "nat_eip" {
  count = length(var.azs)
  domain = "vpc"
}

resource "aws_nat_gateway" "terraform_public_nat_gateway" {

  count = length(var.azs)

  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = var.subnet_allocation_ids[count.index] 

  tags          = merge(
    { Name = "${var.tags.Environment}-nat-gateway-${count.index + 1}"},
    var.tags
  )
}