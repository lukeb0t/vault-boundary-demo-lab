resource "boundary_host_catalog_static" "backend_servers" {
  name        = "backend_servers"
  description = "servers for the backend team"
  scope_id    = boundary_scope.db_infra_proj.id
}

resource "boundary_host_set_static" "vault_servers" {
  name            = "vault cluster nodes"
  description     = "Host set for vault servers"
  host_catalog_id = boundary_host_catalog_static.backend_servers.id
  host_ids        = [boundary_host_static.hc_vault.id]
}

resource "boundary_host_static" "hc_vault" {
  type            = "static"  
  name            = "vault_cluster"
  description     = "vault cluster"
  address         = "${var.vault_host}"
  host_catalog_id = boundary_host_catalog_static.backend_servers.id
}

resource "boundary_host_catalog_static" "ssh_host_cat" {
  name        = "ssh host cat"
  description = "catalog for ssh servers"
  scope_id    = boundary_scope.db_infra_proj.id
}

resource "boundary_host_static" "ssh_host" {
  name            = "ssh_demo_container"
  description     = "ssh host"
  address         = "${var.ssh_host}"
  type = "static"
  host_catalog_id = boundary_host_catalog_static.ssh_host_cat.id
}

resource "boundary_host_set_static" "ssh_hosts" {
  name            = "ssh_hosts"
  description     = "host set ssh hosts"
  host_catalog_id = boundary_host_catalog_static.ssh_host_cat.id
  host_ids        = [boundary_host_static.ssh_host.id]
}


## resources for credential library

resource "boundary_host_catalog_static" "psql_host_cat" {
  name        = "psql host cat"
  description = "catalog for the northwinds database servers"
  scope_id    = boundary_scope.db_infra_proj.id
}

resource "boundary_host_static" "psql" {
  name            = "docker-psql"
  description     = "psql northwinds database"
  address         = "${var.psql_host}"
  type = "static"
  host_catalog_id = boundary_host_catalog_static.psql_host_cat.id
}

resource "boundary_host_set_static" "psql" {
  name            = "psql_hosts"
  description     = "host set for psql northwind servers"
  host_catalog_id = boundary_host_catalog_static.psql_host_cat.id
  host_ids        = [boundary_host_static.psql.id]
}