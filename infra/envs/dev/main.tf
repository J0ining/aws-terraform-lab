provider "aws" {
  region = "eu-south-2"
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Maybe use variables.tf instead


locals {
  fixed_subnets = [
    {
      cidr = "10.0.1.0/24"
      az   = 0
      type = "public"
    },
    {
      cidr = "10.0.11.0/24"
      az   = 0
      type = "private"
    },
    {
      cidr = "10.0.2.0/24"
      az   = 1
      type = "public"
    },
    {
      cidr = "10.0.12.0/24"
      az   = 1
      type = "private"
    },

  ]
}


module "network" {
  source                    = "../../modules/network"
  base_cidr_block           = "10.0.0.0/16"
  availability_zones_region = data.aws_availability_zones.available.names
  subnets_data              = local.fixed_subnets
}

