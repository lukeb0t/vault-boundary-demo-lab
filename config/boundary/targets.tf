resource "boundary_target" "ssh" {
  type                     = "tcp"
  name                     = "ssh"
  description              = "SSH target"
  scope_id                 = boundary_scope.db_infra_proj.id
  session_connection_limit = -1
  default_port             = var.ssh_host_int
  host_source_ids = [
    boundary_host_set_static.ssh_hosts.id
  ]
}

resource "boundary_target" "psql_dba" {
  name         = "psql_dbas"
  description  = "northwinds database targetfor dbas"
  type         = "tcp"
  default_port = var.psql_port_int
  scope_id     = boundary_scope.db_infra_proj.id
  host_source_ids = [
    boundary_host_set_static.psql.id
  ]
  brokered_credential_source_ids = [
    boundary_credential_library_vault.northwind_dba.id
  ]
}

resource "boundary_target" "psql_analysts" {
  name         = "psql_analysts"
  description  = "northwinds database target for analysts"
  type         = "tcp"
  default_port = var.psql_port_int
  scope_id     = boundary_scope.db_infra_proj.id
  host_source_ids = [
    boundary_host_set_static.psql.id
  ]
  brokered_credential_source_ids = [
    boundary_credential_library_vault.northwind_analyst.id
  ]
}

#resource "boundary_target" "vault_ui" {
#  type                     = "tcp"
#  name                     = "vault appplication front end"
#  description              = "hashicorp vault cluster"
#  #worker_filter            = "\"/region\" == \"/${var.region}\""
#  scope_id                 = boundary_scope.db_infra_proj.id
#  session_connection_limit = 0
#  default_port             = 8002
#  host_set_ids = [
#    boundary_host_set.vault_servers.id
#  ]
#}
