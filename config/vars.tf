
variable "vault_port_ext" {
  description = "the configured port to connect to the vault server"
  default     = 8211
}

variable "boundary_port_ext" {
  description = "the configured port to connect to the boundary controller"
  default     = 9211
}

variable "vault_token" {
  default = "root"
}

variable "vault_host" {
  description = "ip or hostname of the vault server"
  default     = "localhost"
}

variable "boundary_host" {
  description = "ip or hostname of the boundary server"
  default     = "localhost"
}

variable "oidc_issuer" {
default = null
}

variable "oidc_client_secret" {
default = null
}

variable "oidc_client_id" {
default = null
}

variable "oidc_subject2" {
default = null
}

variable "oidc_subject1" {
default = null
}

