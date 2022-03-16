variable "psql_port" {
  default     = 5432
  description = "port the vault and boundary servers will use to connect to the psql server"
}

variable "psql_service_accnt" {
  default     = "postgres"
  description = "service account for vault to connect to the psql server"
}

variable "psql_serv_accnt_pw" {
  default     = "postgres"
  description = "service account password for vault to connect to the psql server"
}
variable "psql_hostname" {
  default     = "psql"
  description = "ip or hostname of the psql server"
}

variable "mariadb_hostname" {
  default     = "mariadb"
  description = "ip or hostname of the psql server"
}

variable "root_db" {
  default     = "postgres"
  description = "the master db of the psql server for the vault connection"
}

variable "vault_hostname" {
  default     = "vault-ent"
  description = "ip or hostname of the vault server"
}

variable "vault_host_port" {
  default = 8200
}

variable "vault_license" {
  type = string
  description = "Vault enterprise license key"
}