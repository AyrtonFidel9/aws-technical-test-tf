output "subnets_created_id" {
  description = "subnets crated"
  value = aws_subnet.terraform_vpc_subnets[*].id
}