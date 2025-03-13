output "nat_gateways_id" {
  description = "Nat gateways created"
  value = aws_nat_gateway.terraform_public_nat_gateway[*].id
}