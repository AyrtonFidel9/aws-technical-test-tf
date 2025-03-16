resource "random_string" "random" {
  length           = 5
  special          = false
}

resource "random_password" "master_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "database_credentials" {
  name = "sm-${var.tags.Application}-${var.tags.Environment}-rds-db-${random_string.random.result}"
}

resource "aws_secretsmanager_secret_version" "db_credentials_secret" {
  secret_id     = aws_secretsmanager_secret.database_credentials.id
  secret_string = jsonencode(
  {
    "username": "${var.username}",
    "password": "${random_password.master_password.result}"
  })
}

resource "aws_db_subnet_group" "uplinq_subnet_group" {
  name       = "${var.tags.Application}-${var.tags.Environment}-subnet-group"
  subnet_ids = var.subnets_id
}

resource "aws_db_parameter_group" "db_pm" {
  name   = "${var.tags.Application}-${var.tags.Environment}-db-parameter-group"
  family = var.parameter_group_family
}

resource "aws_security_group" "db_sg" {
  name = "${var.tags.Application}-${var.tags.Environment}-db-sg"

  dynamic "ingress" {
    for_each = var.ingress_subnets_cidr
    content {
      cidr_blocks      = [ ingress.value ]
      from_port        = var.port
      to_port          = var.port
      protocol         = "tcp" 
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = var.vpc_id
}

resource "aws_db_instance" "uplinq_database" {
  allocated_storage    = var.storage
  db_name              = "${var.tags.Application}"
  identifier           = "${var.tags.Application}-${var.tags.Environment}-db" 
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.db_type
  manage_master_user_password = true
  username             = jsondecode(aws_secretsmanager_secret_version.db_credentials_secret.secret_string)["username"] 
  parameter_group_name = aws_db_parameter_group.db_pm.name
  #password             = jsondecode(aws_secretsmanager_secret_version.db_credentials_secret.secret_string)["password"]
  skip_final_snapshot  = true
  max_allocated_storage = var.storage * 10
  storage_encrypted     = true
  db_subnet_group_name = aws_db_subnet_group.uplinq_subnet_group.name
  vpc_security_group_ids = [ aws_security_group.db_sg.id ]
  
  tags = var.tags
}