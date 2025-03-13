output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value = aws_internet_gateway.terraform_internet_gateway.id 
}