locals {
  users_from_yaml = yamldecode(file("${path.module}/user-roles.yaml")).users
}

resource "aws_iam_user" "users" {
  for_each = toset(local.users_from_yaml[*].username)
  name     = each.value
}

resource "aws_iam_user_login_profile" "users" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 8

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}

output "password" {
  value = { for user, user_login in aws_iam_user_login_profile.users : user => user_login.password }
}
output "users" {
  value = local.users_from_yaml
}
