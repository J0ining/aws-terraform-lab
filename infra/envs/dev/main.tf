provider "aws" {
  region = "eu-south-2"
}

module "network" {
  source = "../../modules/network"
}

