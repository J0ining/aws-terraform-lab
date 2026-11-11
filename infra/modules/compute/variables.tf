variable "vpc_id" {
  type        = string
  description = "Main VPC id"
}

variable "alb_sg_id" {
  type        = string
  description = "Main ALB Security Group ID"

}
variable "private_subnet_ids" {

  type        = list(string)
  description = "Private subnets ids"
}

variable "aws_ami_id" {

  type = string

  description = "AWS AMI ID"

}

variable "alb_tg_arn" {

  type = string

  description = "ALB Target Group ARN"

}