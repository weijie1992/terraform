output "module_public_subnets" {
  value = module.networking.public_subnet
}

output "vpc_id" {
  value = module.networking.vpc_id
}
output "output_public_subnets" {
  value = module.networking.output_public_subnets
}

output "output_private_subnets" {
  value = module.networking.output_private_subnets
}
