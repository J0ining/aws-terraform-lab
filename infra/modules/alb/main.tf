resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Security Group for Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ALB Security Group"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  #checkov:skip=CKV_AWS_260: This ALB is public for this lab, open http
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  description       = "Ingress Rule to allow http trafic from the Internet"
}


resource "aws_lb" "lab_alb" {
  #checkov:skip= CKV_AWS_150: No need for deletion protection in lab
  #checkov:skip= CKV_AWS_91: Logging incurs in costs. Not enable
  #checkov:skip= CKV2_AWS_20: Not using https. Reports here but it is an aws_lb_listener problem
  #checkov:skip= CKV2_AWS_28: Not using WAF, incurs in costs
  name                       = "lab-alb-tf"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = var.public_subnet_ids
  drop_invalid_header_fields = true


  tags = {
    Environment = "Development"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  #checkov:skip= CKV_AWS_378: Using HTTP for the lab
  name     = "tf-lab-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path    = "/"
    matcher = 200
  }
}

resource "aws_lb_listener" "alb_listener" {
  #checkov:skip= CKV_AWS_2: Using HTTP for lab. 
  #checkov:skip= CKV_AWS_103: Not using TLS for the lab
  load_balancer_arn = aws_lb.lab_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}