variable "ext_psql_port" {
  default     = 5433
  description = "port the vault and boundary servers will use to connect to the psql server"
}

variable "ext_maria_port" {
  default     = 3307
  description = "port the vault and boundary servers will use to connect to the maria server"
}

variable "ext_vault_port" {
  default = 8211
}

variable "boundary_ui_port" {
  default = 9211
}

variable "boundary_worker_port" {
  default = 9212
}

variable "boundary_other_port" {
  default = 9213
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

variable "ssh_hostname" {
  default     = "ssh_server"
  description = "ip or hostname of the ssh server"
}

variable "vault_license" {
  type        = string
  description = "Vault enterprise license key"
}

variable "open-ssh-server-name" {
  type        = string
  default     = "open-ssh-server"
  description = "name of your open ssh container"
}

variable "vault-agent-hostname" {
  default = "vault-agent-demo"
}

variable "host_files_path" {
  default = "/Users/lukemccleary/hashi-labs/vault-boundary-demo-lab/docker-infra/files"
}
