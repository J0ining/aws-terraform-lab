output "vpc_info" {
  value = module.network.vpc_info
}

output "subnets_info" {
  value = module.network.subnets_info
}


output "public_subnet_ids" {
  value = module.network.public_subnet_ids

}
output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "vpc_id" {

  value = module.network.vpc_id
}


output "alb_dns" {
  value = module.alb.alb_dns
}

output "sg_id" {
  value = module.alb.sg_id
}

output "tg_name" {
  value = module.alb.tg_name
}
