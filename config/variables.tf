
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