output "Vault_Address" {
    value = "http://${var.vault_host}:${var.vault_port}"
}

output "Boundary_Address" {
    value = "http://${var.boundary_host}:${var.boundary_port}"
}

output "Vault_Token" {
  value = var.vault_token
}

output "Boundary_creds" {
  value = "username: Zeus / Pass: rootrootroot"
}

output "approle_role_id" {
  value       = module.vault.approle_role_id
  description = "The RoleID of this role"
}

output "approle_role_secret_id" {
  value       = module.vault.approle_role_secret_id
  sensitive   = true
  description = "The secret ID of the role to log in with"
}

output "approle_role_token" {
  value = module.vault.approle_role_token
}

