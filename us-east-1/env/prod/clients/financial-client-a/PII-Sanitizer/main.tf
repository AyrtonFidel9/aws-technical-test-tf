module "financial-client-a-sanitizer" {
  source = "../../../../../../modules/pii-sanitizer"

  ami_instance_id       = data.aws_ami.amazon_linux.id
  instance_type         = var.instance_type
  public_subnets_id     = data.terraform_remote_state.tf_subnets.outputs.public_subnets_id
  instance_subnet_id    = data.terraform_remote_state.tf_subnets.outputs.pii_sanitizer_subnets_id[0]
  vpc_id                = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  user_data             = "${file("user_data.sh")}" 
  public_ip_address     = false 

  tags = {
    Description         = "Dynamo DB table for client A"
    Environment         = var.environment
    CreatedBy           = var.created_by
    Application         = var.application
    CostCenter          = var.cost_center
    Contact             = var.contact
    MaintenanceWindow   = var.maintenance_window
    DeletionDate        = var.deletion_date
  }
}