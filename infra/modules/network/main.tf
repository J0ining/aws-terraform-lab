resource "aws_vpc" "main" {
  #checkov:skip=CKV2_AWS_11: Flow logs adds additional cost. Not enable in lab enviroment
  cidr_block       = var.base_cidr_block
  instance_tenancy = "default" #Shared hardware. Default option. "Dedicated" option charges a fee

  tags = {
    Name = "Main VPC"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main IGW"
  }
}


resource "aws_subnet" "main" {

  for_each = { for subnet in var.subnets_data : "${subnet.type}.${var.availability_zones_region[subnet.az]}" => subnet }

  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones_region[each.value.az]
  cidr_block        = each.value.cidr

  tags = {
    Name = "Main ${each.value.type} Subnet ${var.availability_zones_region[each.value.az]}"
    Type = each.value.type
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}



resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "route_association" {
  for_each  = aws_subnet.main
  subnet_id = each.value.id

  route_table_id = each.value.tags.Type == "public" ? aws_route_table.public.id : aws_route_table.private.id
}

resource "aws_eip" "eip_nat" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = local.public_subnet_ids[0]

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.gw]
}
