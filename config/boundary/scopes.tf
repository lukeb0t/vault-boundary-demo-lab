resource "boundary_scope" "global" {
  global_scope = true
  name         = "ATARC Global Scope"
  scope_id     = "global"
}

resource "boundary_scope" "core_infra" {
  scope_id    = boundary_scope.global.id
  name        = "Core_Infrastucture"
  description = "Core Infrastructure Scope"
}

resource "boundary_scope" "db_infra_proj" {
  name        = "DB_Infrastructure"
  description = "Database Infrastrcture Project"
  scope_id    = boundary_scope.core_infra.id
}

resource "boundary_scope" "hcp" {
  scope_id    = boundary_scope.global.id
  name        = "High_Performance_Computing"
  description = "HPC Scope"
}

