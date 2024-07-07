locals {
  firstnames_from_splat       = var.objects_list[*].firstname
  roles_from_splat_with_value = values(local.users_map2)[*].roles
}

output "firstnames_from_splat" {
  value = local.firstnames_from_splat
}


output "roles_from_splat_with_value" {
  value = local.roles_from_splat_with_value
}
