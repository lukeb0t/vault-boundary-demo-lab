
variable "psql_port" {
  description = "port the vault and boundary servers will use to connect to the psql server"
  default = 5432
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
  description = "configured port for mariadb instance"
  default = 3306
}

variable "psql_root_db" {
  description = "the master db of the psql server for the vault connection"
  default     = "postgres"
}