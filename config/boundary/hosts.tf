resource "boundary_host_catalog" "backend_servers" {
  name        = "backend_servers"
  description = "servers for the backend team"
  type        = "static"
  scope_id    = boundary_scope.db_infra_proj.id
}

resource "boundary_host_set" "vault_servers" {
  type            = "static"
  name            = "vault cluster nodes"
  description     = "Host set for vault servers"
  host_catalog_id = boundary_host_catalog.backend_servers.id
  host_ids        = [boundary_host.hc_vault.id]
}
resource "boundary_host_set" "database_servers" {
  type            = "static"
  name            = "db_host_set"
  description     = "Host set for db servers"
  host_catalog_id = boundary_host_catalog.backend_servers.id
  host_ids = [boundary_host.postgres_sql.id]
}

resource "boundary_host" "postgres_sql" {
  type            = "static"
  name            = "psql server"
  description     = "psql demo database"
  address         = "${var.controller_private_ip}"
  host_catalog_id = boundary_host_catalog.backend_servers.id
}
resource "boundary_host" "hc_vault" {
  type            = "static"
  name            = "vault_cluster"
  description     = "vault cluster"
  address         = "${var.vault_private_ip}"
  host_catalog_id = boundary_host_catalog.backend_servers.id
}