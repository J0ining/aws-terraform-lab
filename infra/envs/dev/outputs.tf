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