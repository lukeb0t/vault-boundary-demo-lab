resource "vault_mount" "ssh_client_signer" {
  type        = "ssh"
  path        = "ssh_client_signer"
  description = "SSH engine for signging SSH keys"
}

resource "vault_ssh_secret_backend_ca" "ssh_client-signer" {
    backend = vault_mount.ssh_client_signer.path
    generate_signing_key = false
    public_key = file("../docker-infra/files/vault_keys.pub")
    private_key = file("../docker-infra/files/vault_keys")
}

resource "vault_ssh_secret_backend_role" "admin" {
    name          = "admin"
    backend       = vault_mount.ssh_client_signer.path
    key_type      = "ca"
    default_user  = "admin"
    allowed_users = "*"
    allowed_extensions = "permit-pty,permit-port-forwarding"
    default_extensions = {"permit-pty": "", permit-port-forwarding: ""}
    allow_user_certificates = true
    ttl = "60m"
    cidr_list     = "0.0.0.0/0"
}

resource "vault_ssh_secret_backend_role" "sec_ops" {
    name          = "security_ops"
    backend       = vault_mount.ssh_client_signer.path
    key_type      = "ca"
    default_user  = "sec_ops"
    allowed_users = "sec_ops"
    allowed_extensions = "permit-pty,permit-port-forwarding"
    default_extensions = {"permit-pty": "", permit-port-forwarding: ""}
    allow_user_certificates = true
    ttl = "60m"
    cidr_list     = "0.0.0.0/0"
}

resource "vault_ssh_secret_backend_role" "backup_ops" {
    name          = "backup_ops"
    backend       = vault_mount.ssh_client_signer.path
    key_type      = "ca"
    default_user  = "backup_ops"
    allowed_users = "backup_ops"
    allowed_extensions = "permit-pty,permit-port-forwarding"
    default_extensions = {"permit-pty": "", permit-port-forwarding: ""}
    allow_user_certificates = true
    ttl = "60m"
    cidr_list     = "0.0.0.0/0"
}

resource "vault_policy" "ssh_admin" {
  name   = "ssh-admin"
  policy = <<EOT
path "ssh_client_signer/roles" {
  capabilities = ["list"]
}

path "ssh_client_signer/sign/admin" {
  capabilities = ["update", "create"]
}
EOT
}

resource "vault_policy" "ssh_backup_ops" {
  name   = "ssh-backup-ops"
  policy = <<EOT
path "ssh_client_signer/roles" {
  capabilities = ["list"]
}

path "ssh_client_signer/sign/backup_ops" {
  capabilities = ["update", "create"]
}
EOT
}

resource "vault_policy" "ssh_security_ops" {
  name   = "ssh-sec-ops"
  policy = <<EOT
path "ssh_client_signer/roles" {
  capabilities = ["list"]
}

path "ssh_client_signer/sign/security_ops" {
  capabilities = ["update", "create"]
}
EOT
}



# resource "vault_ssh_secret_backend_role" "otp" {
#   provider   = vault.finance
#   name = "otp-role"
#   backend = vault_mount.ssh.path
#   default_user = "vault"
#   key_type = "otp"
#   cidr_list = "0.0.0.0/0"
# }