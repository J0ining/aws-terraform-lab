output "alb_dns" {
  value = aws_lb.lab_alb.dns_name

  description = "DNS name of the load balancer"
}

output "sg_id" {
  value = aws_security_group.alb_sg.id

  description = "ID of the security group"
}

output "tg_name" {
  value = aws_lb_target_group.alb_tg.name

  description = "Name of the target group"

}

output "alb_tg_arn" {

  value = aws_lb_target_group.alb_tg.arn

  description = "ALB Targert Group ARNM"

}