provider "aws" {
  region = "eu-south-2"
}

data "aws_availability_zones" "available" {
  state = "available"
}


module "network" {
  source          = "../../modules/network"
  base_cidr_block = "10.0.0.0/16"
  availability_zones_region= data.aws_availability_zones.available.names
}

