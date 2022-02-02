
variable "psql_port" {
  description = "port the vault and boundary servers will use to connect to the psql server"
  default     = 5432
}

variable "psql_user" {
  description = "service account for vault to connect to the psql server"
  default     = "postgres"
}

variable "psql_pw" {
  description = "service account password for vault to connect to the psql server"
  default     = "postgres"
}
variable "psql_host" {
  description = "internal ip or hostname of the psql server"
  default     = "psql"
}

variable "mariadb_host" {
  description = "internal ip or hostname of the mariaDB server"
  default     = "mariadb"
}

variable "maria_user" {
  default = "root"
  description = "MariaDB service account username"
}

variable "maria_pw" {
  default = "root"
  description = "MariaDB service account password"
}

variable "mariadb_port" {
  default = 3306
  description = "configured port for mariadb instance"
}

variable "psql_root_db" {
  description = "the master db of the psql server for the vault connection"
  default     = "postgres"
}

variable "vault_host" {
  description = "ip or hostname of the vault server"
  default     = "localhost"
}

variable "vault_port" {
  description = "the configured port to connect to the vault server"
  default     = 8200
}

variable "vault_token" {
  default = "root"
}