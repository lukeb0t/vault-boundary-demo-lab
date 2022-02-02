resource "vault_mount" "infra-creds" {
  path        = "infrastructure_creds"
  type        = "kv-v2"
  description = "Infrastructure admin credentials"
}

