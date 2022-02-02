resource "boundary_role" "global_org_admin" {
  name           = "global_org_admin"
  scope_id       = boundary_scope.global.id
  grant_scope_id = boundary_scope.global.id
  grant_strings = [
    "id=*;type=*;actions=*"
  ]
  principal_ids = [boundary_group.global_admins.id,]
}

resource "boundary_role" "hpc_org_admin" {
  name           = "hpc_org_admin"
  scope_id       = boundary_scope.global.id
  grant_scope_id = boundary_scope.hcp.id
  grant_strings = [
    "id=*;type=*;actions=*"
  ]
  principal_ids = [
    boundary_group.global_admins.id,
    boundary_group.hpc_admins.id]
}
resource "boundary_role" "core_infra_admin" {
  name           = "core_infra_admin"
  scope_id       = boundary_scope.core_infra.id
  grant_scope_id = boundary_scope.core_infra.id
  grant_strings = [
    "id=*;type=*;actions=*"
  ]
  principal_ids = [
    boundary_group.infra_admins.id,
    boundary_group.global_admins.id]
}
resource "boundary_role" "infra_proj_admin" {
  name           = "infra_proj_admin"
  description    = "admin role for the infra project"
  scope_id       = boundary_scope.core_infra.id
  grant_scope_id = boundary_scope.db_infra_proj.id
  grant_strings = [
    "id=*;type=*;actions=*"
  ]
  principal_ids = [
    boundary_group.infra_admins.id,
    boundary_group.global_admins.id]
}

resource "boundary_role" "global_anon_listing" {
  name     = "global_anon"
  scope_id = boundary_scope.global.id
  grant_strings = [
    "id=*;type=scope;actions=list,no-op",
    "id=*;type=auth-method;actions=authenticate,list",
    "id={{account.id}};actions=read,change-password",
    "id=*;type=auth-token;actions=list,read:self,delete:self"
  ]
  principal_ids = ["u_anon"]
}
resource "boundary_role" "core_infra_anon_listing" {
  name        = "anon"
  description = "role for anon auth'd users"
  scope_id    = boundary_scope.core_infra.id
  grant_strings = [
    "id=*;type=scope;actions=list,no-op",
    "id=*;type=auth-method;actions=authenticate,list",
    "id={{account.id}};actions=read,change-password",
    "id=*;type=auth-token;actions=list,read:self,delete:self"
  ]
  principal_ids = ["u_anon"]

}
resource "boundary_role" "core_infra_readonly" {
  name        = "readonly"
  description = "Read-only role"
  principal_ids = [
    boundary_group.read_only.id
  ]
  grant_strings = [
    "id=*;type=*;actions=read"
  ]
  scope_id       = boundary_scope.core_infra.id
  grant_scope_id = boundary_scope.core_infra.id
}