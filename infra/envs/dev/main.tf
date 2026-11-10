

data "aws_availability_zones" "available" {
  #checkov:skip=CKV_AWS_394: AZ selected using indexes and risk accepted for the lab enviroment
  state = "available"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical: checked with describe-images
}



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

module "alb" {
  source            = "../../modules/alb"
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids

  depends_on = [
    module.network
  ]

}

module "compute" {
  source             = "../../modules/compute"
  vpc_id             = module.network.vpc_id
  alb_id             = module.alb.sg_id
  aws_ami_id         = data.aws_ami.ubuntu.id
  private_subnet_ids = module.network.private_subnet_ids

  depends_on = [
    module.network
  ]

}
