output "compute_sg_id" {
  value = aws_security_group.compute_sg.id

  description = "ID of the security group"
}