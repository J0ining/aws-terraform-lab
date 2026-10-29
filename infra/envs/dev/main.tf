provider "aws" {
  region = "eu-south-2"
}

module "network" {
  source          = "../../modules/network"
  base_cidr_block = "10.0.0.0/16"
}

