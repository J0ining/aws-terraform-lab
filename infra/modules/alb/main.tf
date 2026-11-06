resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Security Group for Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ALB Security Group"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# TODO: egress to resources

resource "aws_lb" "lab_alb" {
  name               = "lab-alb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids

  tags = {
    Environment = "Development"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "tf-lab-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.lab_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}