variable "private_subnet_ids" {

  type        = list(string)
  description = "Private subnets ids"
}

variable "vpc_id" {
  type        = string
  description = "Main VPC id"
}

variable "compute_sg_id" {
  type        = string
  description = "Main Compute Security Group ID"
}

variable "db_user" {
  type        = string
  description = "DB Username"
}

variable "db_multi_az" {
  type        = bool
  description = "DB Multi AZ state"
}