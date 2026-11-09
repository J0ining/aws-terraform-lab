resource "aws_security_group" "compute_sg" {
  name        = "compute_sg"
  description = "Security Group for Compute Resources"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Compute Security Group"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.compute_sg.id
  referenced_security_group_id = var.alb_id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_instance" "simple_instance" {
    #for_each private subnets or asg
    ami           = var.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    security_groups = [compute_sg.id]
    subnet_id= var.private_subnet_ids[0]
    user_data = ""
    tags = {
        Name = "HelloWorld"
    }
}