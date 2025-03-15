resource "aws_lb" "sanitizer_lb" {
  name               = "${var.tags.Application}-${var.tags.Environment}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.public_subnets_id

  enable_deletion_protection = false

  tags = merge({
    Name = "${var.tags.Application}-${var.tags.Environment}-lb",
  }, var.tags)
}

resource "aws_lb_target_group" "sanitizer_target_group" {
  name     = "${var.tags.Application}-${var.tags.Environment}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "attach_instance_to_tg" {
  target_group_arn = aws_lb_target_group.sanitizer_target_group.arn
  target_id        = aws_instance.ec2_instance.id
  port             = 80
}

resource "aws_lb_listener" "pii_instance_listener" {
  load_balancer_arn = aws_lb.sanitizer_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sanitizer_target_group.arn
  }
}