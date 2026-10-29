resource "aws_vpc" "main" {
  cidr_block       = var.base_cidr_block
  instance_tenancy = "default" #Shared hardware. Default option. "Dedicated" option charges a fee

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public" {
  for_each= var.availability_zones_region
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"


  tags = {
    Name = "Main"
  }
}
