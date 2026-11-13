resource "aws_security_group" "compute_sg" {
  name        = "compute_sg"
  description = "Security Group for Compute Resources"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Compute Security Group"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_http_from_alb" {
  #checkov:skip=CKV_AWS_260: This HTTP communication from ALB
  security_group_id            = aws_security_group.compute_sg.id
  referenced_security_group_id = var.alb_sg_id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
  description                  = "Compute Ingress rule for communication from ALB to instances"
}

resource "aws_vpc_security_group_egress_rule" "allow_http_to_instances" {
  #ALB egress rule: No circular dependency
  security_group_id            = var.alb_sg_id
  referenced_security_group_id = aws_security_group.compute_sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80

  description = "ALB Egress rule for communication from ALB to instances"
}

resource "aws_vpc_security_group_egress_rule" "allow_internet_ipv4" {
  for_each = {
    "http"  = 80,
    "https" = 443
  }
  security_group_id = aws_security_group.compute_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.value
  ip_protocol       = "tcp"
  to_port           = each.value
  description       = "Compute Egress rule for communication from instances to the internet"
}

resource "aws_launch_template" "instances_template" {
  name_prefix            = "instances-template"
  vpc_security_group_ids = [aws_security_group.compute_sg.id]
  image_id               = var.aws_ami_id
  instance_type          = "t3.micro"
  metadata_options {
    http_tokens = "required"
  }
  user_data = filebase64("${path.module}/user_data.sh")
}

resource "aws_autoscaling_group" "asg_instances" {
  vpc_zone_identifier       = var.private_subnet_ids
  desired_capacity          = 2
  max_size                  = 2
  min_size                  = 2
  health_check_type         = "ELB"
  health_check_grace_period = 120

  target_group_arns = [var.alb_tg_arn]

  launch_template {
    id = aws_launch_template.instances_template.id
  }

  tag {
    key                 = "Name"
    value               = "terraform"
    propagate_at_launch = true
  }
}