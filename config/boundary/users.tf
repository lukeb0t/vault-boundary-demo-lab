## need to add auth0 account to boundary admin user


resource "boundary_user" "kelly" {
  count       = var.enable_oidc ? 1 : 0
  name        = "kelly"
  description = "OIDC globally scoped admin user kelly"
  account_ids = [boundary_account_oidc.kelly[0].id]
  scope_id    = boundary_scope.global.id
}


resource "boundary_user" "dave" {
  count       = var.enable_oidc ? 1 : 0
  name        = "dave"
  description = "OIDC globally scoped admin user dave"
  account_ids = [
  boundary_account_oidc.dave[0].id]
  scope_id = boundary_scope.global.id
}

resource "boundary_user" "zeus" {
  name        = "zeus"
  description = "password account for zeus"
  account_ids = [
  boundary_account_password.zues.id]
  scope_id = boundary_scope.global.id
}

resource "boundary_user" "hermes" {
  name        = "hermes"
  description = "password account for hermes"
  account_ids = [
  boundary_account_password.hermes.id]
  scope_id = boundary_scope.global.id
}

resource "boundary_user" "hera" {
  name        = "hera"
  description = "password account for hera"
  account_ids = [
  boundary_account_password.hera.id]
  scope_id    = boundary_scope.global.id
}

resource "boundary_user" "ares" {
  name        = "ares"
  description = "password account for ares"
  account_ids = [
  boundary_account_password.ares.id]
  scope_id    = boundary_scope.global.id
}
