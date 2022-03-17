

resource "boundary_account_password" "zeus" {
  name           = "zeus"
  login_name     = "zeus"
  description    = "global admin account for the other god of thunder"
  type           = "password"
  password       = var.users_password
  auth_method_id = boundary_auth_method_password.global_pass.id
}

resource "boundary_account_password" "hermes" {
  name           = "hermes"
  login_name     = "hermes"
  description    = "child scoped account, for a lesser diety"
  type           = "password"
  password       = var.users_password
  auth_method_id = boundary_auth_method_password.global_pass.id
}

resource "boundary_account_password" "hera" {
  name           = "hera"
  login_name     = "hera"
  description    = "global account for hera, read only"
  type           = "password"
  password       = var.users_password
  auth_method_id = boundary_auth_method_password.global_pass.id
}
resource "boundary_account_password" "ares" {
  name           = "ares"
  login_name     = "ares"
  description    = "global account for ares"
  type           = "password"
  password       = var.users_password
  auth_method_id = boundary_auth_method_password.global_pass.id
}