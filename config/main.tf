provider "boundary" {
  addr             = "http://localhost:9200"
  recovery_kms_hcl = <<EOT
kms "aead" {
  purpose = "recovery"
  aead_type = "aes-gcm"
  key = "nIRSASgoP91KmaEcg/EAaM4iAkksyB+Lkes0gzrLIRM="
  key_id = "global_recovery"
}
EOT
}
provider "vault" {
  address = "http://${var.vault_host}:${var.vault_port}"
  token   = var.vault_token
}

provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.core_infra.id, "/")
  alias     = "core_infra"
}

provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.database_team.id, "/")
  alias     = "database_team"
}
provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.web_team.id, "/")
  alias     = "web_team"
}
provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.high_performance_computing.id, "/")
  alias     = "hpc"
}

provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.boundary.id, "/")
  alias     = "boundary"
}

provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.boundary.id, "/")
  alias     = "finance"
}

module "vault" {
source = "./vault"
  providers = {
    vault.finance = vault.finance
  }
}

module "boundary" {
source = "./boundary"
vault_token_boundary = module.vault.boundary_vault_token
}