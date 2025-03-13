output "route_tables_id" {
  value = aws_route_table.terraform_route_table[*].id
}

# output "private_route_tables_id" {
#   value = aws_route_table.terraform_private_route_table[*].id
# }

# output "isolated_route_tables_id" {
#   value = aws_route_table.terraform_isolated_route_table[*].id
# }
