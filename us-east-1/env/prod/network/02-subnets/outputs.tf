output "public_subnets_id" {
  description = "public subnets id created"
  value = module.public_subnets.subnets_created_id
}

output "pii_sanitizer_subnets_id" {
  description = "pii_sanitizer private subnets id created"
  value = module.pii_sanitizer_subnets.subnets_created_id
}

output "gateway_api_subnets_id" {
  description = "gateway_api private subnets id created"
  value = module.gateway_api_subnets.subnets_created_id
}

output "inference_domain_subnets_id" {
  description = "inference_domain private subnets id created"
  value = module.inference_domain_subnets.subnets_created_id
}

output "isolated_subnets_id" {
  description = "isolated subnets id created"
  value = module.isolated_subnets.subnets_created_id
}
