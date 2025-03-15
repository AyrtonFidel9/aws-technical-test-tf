
resource "random_password" "master_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "database_credentials" {
  name = "sm-${var.tags.Application}-${var.tags.Environment}-rds-db-${random_string.random.result}"
}

resource "aws_secretsmanager_secret_version" "db_credentials_secret" {
  secret_id     = aws_secretsmanager_secret.database_credentials.id
  secret_string = <<EOF
{
  "username": "${var.username}",
  "password": "${random_password.master_password.result}",
}
EOF
}

resource "aws_db_subnet_group" "uplinq_subnet_group" {
  name       = "${var.tags.Application}-${var.tags.Environment}-subnet-group"
  subnet_ids = var.subnets_id
}

resource "aws_db_security_group" "db_sg" {
  name = "${var.tags.Application}-${var.tags.Environment}-sg"

  dynamic "ingress" {
    for_each = var.ingress_subnets_cidr
    content {
      cidr = var.ingress.value
    }
  }
}

resource "aws_db_instance" "uplinq_database" {
  allocated_storage    = var.storage
  db_name              = "${var.tags.Application}-${var.tags.Environment}-db"
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.db_type
  manage_master_user_password = true
  username             = aws_secretsmanager_secret_version.db_credentials_secret[0]["username"] 
  parameter_group_name = var.parameter_group_name
  password             = aws_secretsmanager_secret_version.db_credentials_secret[0]["password"]
  skip_final_snapshot  = true
  max_allocated_storage = var.storage * 10
  storage_encrypted     = true
  db_subnet_group_name = aws_db_subnet_group.uplinq_subnet_group.name
  vpc_security_group_ids = [ aws_db_security_group.db_sg.id ]
  
  tags = var.tags
}