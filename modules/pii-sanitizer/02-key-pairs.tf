
resource "tls_private_key" "tls_server" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.tags.Application}-${var.tags.Environment}-key-pair"
  public_key = tls_private_key.tls_server.public_key_openssh
}

resource "random_string" "random" {
  length           = 5
  special          = false
}

# Store SSH PRIVATE KEY on Secrets Manager
resource "aws_secretsmanager_secret" "instance_sm" {
  name = "sm-${var.tags.Application}-${var.tags.Environment}-key-pair-${random_string.random.result}"
}

resource "aws_secretsmanager_secret_version" "instance_sm_stored" {
  secret_id     = aws_secretsmanager_secret.instance_sm.id
  secret_string = tls_private_key.tls_server.private_key_pem
}