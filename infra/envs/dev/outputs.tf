output "vpc_info" {
  value = module.network.vpc_info
}

output "subnets_info" {
  value = {
    "Subnets" = module.network.subnets_info
    "IDs" = {
      "Public IDs"  = module.network.public_subnet_ids
      "Private IDs" = module.network.private_subnet_ids
    }
  }
}

output "alb_info" {

  value = {
    "DNS"               = module.alb.alb_dns
    "Security Group ID" = module.alb.sg_id
    "Target Group Name" = module.alb.tg_name
  }

}

output "route_tables" {

  value = {
    "Public"  = module.network.public_route_table_info
    "Private" = module.network.private_route_table_info
  }

}

output "nat_gateway_info" {
  value = module.network.nat_gateway_info
}