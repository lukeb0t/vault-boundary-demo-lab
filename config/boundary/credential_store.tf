resource "boundary_credential_store_vault" "creds_store" {
  name        = "infra_creds_store"
  description = "credential store for the infrastructure project"
  scope_id    = boundary_scope.db_infra_proj.id
  address     = "http://${var.vault_host}:${var.vault_port_int}"
  token       = var.vault_token_boundary
}

resource "boundary_credential_library_vault" "northwind_dba" {
  name                = "northwind_dba"
  description         = "creds library for the northwinds dbas"
  credential_store_id = boundary_credential_store_vault.creds_store.id
  path                = "databases/creds/postgres_dba"
}
resource "boundary_credential_library_vault" "northwind_analyst" {
  name                = "northwind_analyst"
  description         = "creds library for the northwinds db analysts"
  credential_store_id = boundary_credential_store_vault.creds_store.id
  path                = "databases/creds/postgres_analyst"
}
