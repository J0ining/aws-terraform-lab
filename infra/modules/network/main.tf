resource "aws_vpc" "main" {
  cidr_block       = var.base_cidr_block
  instance_tenancy = "default" #Shared hardware. Default option. "Dedicated" option charges a fee

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {

  for_each = {for subnet in var.subnets_data :"${subnet.type}.${var.availability_zones_region[subnet.az]}" => subnet}
  
  vpc_id     = aws_vpc.main.id
  availability_zone  = var.availability_zones_region[each.value.az]
  cidr_block = each.value.cidr

  tags = {
    Name = "Main ${each.value.type} Subnet ${var.availability_zones_region[each.value.az]} "
  }
}