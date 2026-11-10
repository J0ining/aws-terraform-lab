variable "vpc_id" {
  type        = string
  description = "Main VPC id"
}

variable "alb_id" {
  type        = string
  description = "Main ALB id"

}
variable "private_subnet_ids" {

  type        = list(string)
  description = "Private subnets ids"
}

variable "aws_ami_id" {

  type = string

  description = "AWS AMI ID"

}