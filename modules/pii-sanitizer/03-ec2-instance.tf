resource "aws_instance" "ec2_instance" {
  ami           = var.ami_instance_id
  instance_type = var.instance_type
  subnet_id     = var.instance_subnet_id
  
  vpc_security_group_ids        = [ aws_security_group.ec2_sg.id ]
  ebs_optimized                 = var.ebs_optimized
  key_name                      = aws_key_pair.generated_key.key_name
  associate_public_ip_address   = var.public_ip_address

  user_data = var.user_data

  iam_instance_profile          = "AmazonSSMRoleForInstancesQuickSetup"

  ebs_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
    encrypted   = var.ebs_encrypted
    device_name = var.device_name
  }

  metadata_options {
    instance_metadata_tags = "enabled"
    http_tokens            = "required"
  }
}