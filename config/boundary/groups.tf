resource "boundary_group" "global_admins" {
  name        = "global_admins"
  description = "group for global admins"
  member_ids = compact([boundary_user.zues.id,
  var.enable_oidc ? boundary_user.dave[0].id : null])
  scope_id = boundary_scope.global.id
}

resource "boundary_group" "infra_admins" {
  name        = "infra_admins"
  description = "group for dev org admins"
  member_ids = compact([boundary_user.hermes.id,
  var.enable_oidc ? boundary_user.kelly[0].id : null])
  scope_id = boundary_scope.global.id
}

resource "boundary_group" "hpc_admins" {
  name        = "hpc_admins"
  description = "group for global admins"
  member_ids = compact([boundary_user.zues.id,
  var.enable_oidc ? boundary_user.dave[0].id : null])
  scope_id = boundary_scope.global.id
}

resource "boundary_group" "read_only" {
  name        = "read_only"
  description = "ready and list access only"
  member_ids = [boundary_user.hermes.id]
  scope_id = boundary_scope.global.id
}
