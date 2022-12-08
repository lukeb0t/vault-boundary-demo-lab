output "approle_role_id" {
  value       = vault_approle_auth_backend_role.terraform_read.role_id
  description = "The RoleID of this role"
}

output "approle_role_secret_id" {
  value       = vault_approle_auth_backend_role_secret_id.id.secret_id
  sensitive   = true
  description = "The secret ID of the role to log in with"
}

output "approle_role_token" {
  value = vault_approle_auth_backend_login.login.client_token
}

output "boundary_vault_token" {
  value = vault_token.boundary.client_token
}

