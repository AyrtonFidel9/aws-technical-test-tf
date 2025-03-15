resource "aws_vpc_endpoint" "dynamodb_endpoint_for_inference_domain" {
  vpc_id             = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  service_name       = "com.amazonaws.${var.region}.dynamodb"
  vpc_endpoint_type  = "Gateway"
  route_table_ids    = data.terraform_remote_state.tf_route_tables.outputs.inference_domain_route_tables
}

resource "aws_vpc_endpoint" "s3_endpoint_for_inference_domain" {
  vpc_id             = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  service_name       = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type  = "Gateway"
  route_table_ids    = data.terraform_remote_state.tf_route_tables.outputs.inference_domain_route_tables
}