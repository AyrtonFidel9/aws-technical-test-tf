//Route tables
resource "aws_route_table" "terraform_route_table" {
  count = length(var.subnets)

  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.internet_gateway_id != "no-id" ? [1] : [] 
    content {
      cidr_block = var.cidr_igw
      gateway_id = var.internet_gateway_id
    }
  }

  dynamic "route" {
    for_each = length(var.nat_gateways_id) == 0 ? [] : [1] 
    content {
      cidr_block = var.cidr_nat
      nat_gateway_id = count.index < length(var.nat_gateways_id) ?  var.nat_gateways_id[count.index] : var.nat_gateways_id[0]
    }
  }

  tags = merge(var.tags, {
    Name = var.additional_name == "no-name" ? "rt-${var.type}-${var.tags.Environment}-${count.index + 1 }" : "rt-${var.additional_name}-${var.type}-${var.tags.Environment}-${count.index + 1 }" 
  })
}

resource "aws_route_table_association" "tf_public_rt_association" {
  count = length(var.subnets)
  subnet_id = var.subnets[count.index].id
  route_table_id = aws_route_table.terraform_route_table[count.index].id
}