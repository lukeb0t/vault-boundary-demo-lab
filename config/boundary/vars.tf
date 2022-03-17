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

variable "backend_team" {
  type = set(string)
  default = [
    "jim",
    "mike",
    "todd",
  ]
}

variable "frontend_team" {
  type = set(string)
  default = [
    "randy",
    "susmitha",
  ]
}

variable "leadership_team" {
  type = set(string)
  default = [
    "jeff",
    "pete",
    "jonathan",
    "malnick"
  ]
}

variable "target_ips" {
  type    = set(string)
  default = ["192.168.1.10"]
}

variable "kms_recovery_key_id" {
  default = null
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

variable "int_psql_port" {
default = 5432
}

variable "int_vault_port" {
default = 8200
}

variable "ext_boundary_port" {
default = 9211
}

