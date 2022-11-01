resource "vault_mount" "ssh-signer" {
  type        = "ssh"
  path        = "ssh-signer"
  description = "SSH engine for signging SSH keys"
}

resource "vault_ssh_secret_backend_ca" "ssh-signer" {
    backend = vault_mount.ssh-signer.path
    generate_signing_key = false
    public_key = file("../docker-infra/files/vault_keys.pub")
    private_key = file("../docker-infra/files/vault_keys")
}

resource "vault_ssh_secret_backend_role" "admin" {
    name          = "admin"
    backend       = vault_mount.ssh-signer.path
    key_type      = "ca"
    default_user  = "admin"
    allowed_users = "*"
    allowed_extensions = "permit-pty,permit-port-forwarding"
    default_extensions = {"permit-pty": "", permit-port-forwarding: ""}
    allow_user_certificates = true
    ttl = "60m"
    cidr_list     = "0.0.0.0/0"
}

resource "vault_policy" "ssh" {
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



# resource "vault_ssh_secret_backend_role" "otp" {
#   provider   = vault.finance
#   name = "otp-role"
#   backend = vault_mount.ssh.path
#   default_user = "vault"
#   key_type = "otp"
#   cidr_list = "0.0.0.0/0"
# }