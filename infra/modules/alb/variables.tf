variable "vpc_id" {
  type        = string
  description = "Main VPC id"
}

variable "public_subnet_ids" {

  type        = list(string)
  description = "Public subnets ids"
}