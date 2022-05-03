resource "vault_mount" "ssh" {
  provider   = vault.finance
  type        = "ssh"
  path        = "ssh"
  description = "engine for managing privileged ssh sessions"
}

resource "vault_policy" "ssh" {
  provider   = vault.finance
  name   = "ssh-policy"
  policy = <<EOT
path "ssh/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

# to use the configured SSH secrets engine otp_key_role otp_key_role
path "ssh/creds/otp_role" {
  capabilities = ["create", "read", "update"]
}
EOT
}

resource "vault_ssh_secret_backend_role" "otp" {
  provider   = vault.finance
  name = "otp-role"
  backend = vault_mount.ssh.path
  default_user = "vault"
  key_type = "otp"
  cidr_list = "0.0.0.0/0"
}