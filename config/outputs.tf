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