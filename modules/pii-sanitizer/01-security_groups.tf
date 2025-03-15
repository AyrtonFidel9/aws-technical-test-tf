resource "aws_security_group" "lb_sg" {
  name        = "load-balancer-${var.tags.Application}-${var.tags.Environment}-sg"
  description = "Allow traffic from SSH, HTTP and HTTPS"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port   = 80
    protocol = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 443
    protocol = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.tags.Application}-${var.tags.Environment}-sg"
  description = "Allow traffic from SSH, HTTP and HTTPS"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port   = 80
    protocol = "tcp"
    to_port     = 80
    security_groups = [ aws_security_group.lb_sg.id ]
  }

  ingress {
    from_port   = 443
    protocol = "tcp"
    to_port     = 443
    security_groups = [ aws_security_group.lb_sg.id ]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

