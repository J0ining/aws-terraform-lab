output "vpc_info" {
  value = {
    id         = aws_vpc.main.id
    cidr_block = aws_vpc.main.cidr_block
  }
  description = "Main VPC info"
}

output "subnets_info" {
  value = { for k, subnet in aws_subnet.main :
    k => {
      type       = subnet.tags.Type
      id         = subnet.id
      az         = subnet.availability_zone
      cidr_block = subnet.cidr_block
    }
  }
  description = "Subnets info"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "Plain VPC id"
}

output "public_subnet_ids" {

  value       = local.public_subnet_ids
  description = "Public subnets ids"

}

output "private_subnet_ids" {

  value       = local.private_subnet_ids
  description = "Private subnets ids"

}


output "private_route_table_info" {
  value = {
    "Name"   = aws_route_table.private.tags.Name
    "Routes" = aws_route_table.private.route
  }

  description = "Private Route Table Information"
}

output "public_route_table_info" {
  value = {
    "Name"   = aws_route_table.public.tags.Name
    "Routes" = aws_route_table.public.route
  }

  description = "Public Route Table Information"
}

output "nat_gateway_info" {

  value = {

    "EIP" = aws_nat_gateway.main.allocation_id

  }

  description = "Nat Gateway Information"

}