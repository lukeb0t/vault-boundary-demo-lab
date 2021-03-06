variable "oidc_subject2" {
  description = "oidc subject string for global admin"
  default     = null
}
variable "oidc_subject1" {
  description = "oidc subject string for dev org admin"
  default     = null
}

variable "enable_oidc" {
  default = false
}

variable "target_ips" {
  type    = set(string)
  default = ["192.168.1.10"]
}

variable "oidc_client_id" {
  description = "oidc provider client ID"
  sensitive   = true
  default     = null
}

variable "oidc_client_secret" {
  description = "oidc provider client secret"
  sensitive   = true
  default     = null
}

variable "oidc_issuer" {
  description = "oidc provider issuer URL"
  default     = null
}

variable "users_password" {
default= "rootrootroot"
}

variable "vault_host" {
default = "vault-ent"
description = "the vault ip or hostname network adjacent to the boundary controller. This may be inside the docker network"
}

variable "psql_host" {
  default = "postgres-sql"
}

variable  "vault_token_boundary"{
description = "vault token for credential store access"
}

### DO NOT MODIFY THESE PORTS, THEY ARE CONTAINED WITH DOCKER

variable "psql_port_int" {
default = 5432
}

variable "vault_port_int" {
default = 8200
}

variable "boundary_port_ext" {
default = 9211
}

