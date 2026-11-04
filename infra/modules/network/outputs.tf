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

  value       = [for subnet in aws_subnet.main : subnet.id if subnet.tags.Type == "public"]
  description = "Public subnets ids"

}

output "private_subnet_ids" {

  value       = [for subnet in aws_subnet.main : subnet.id if subnet.tags.Type == "private"]
  description = "Private subnets ids"

}
