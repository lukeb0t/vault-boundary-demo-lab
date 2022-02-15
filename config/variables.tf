
variable "vault_token" {
  default = "root"
}

variable "vault_host" {
  description = "ip or hostname of the vault server"
  default     = "localhost"
}

variable "vault_port" {
  description = "the configured port to connect to the vault server"
  default     = 8200
}

variable "oidc_issuer" {}
variable "oidc_client_secret" {}
variable "oidc_client_id" {}
variable "oidc_subject2" {}
variable "oidc_subject1" {}