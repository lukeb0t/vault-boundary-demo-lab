resource "vault_mount" "ssh-client-signer" {
  type        = "ssh"
  path        = "ssh-client-signer"
  description = "SSH engine for signging SSH keys"
}

resource "vault_ssh_secret_backend_ca" "ssh-client-signer" {
  backend              = vault_mount.ssh-client-signer.path
  generate_signing_key = true
}

resource "null_resource" "ssh_client_setup" {
  provisioner "remote-exec" {
    connection {
      host     = "localhost"
      port     = 2222
      user     = "admin"
      type     = "ssh"
      password = "Hashi123#"
      timeout  = "2m"

    }

    inline = [<<EOT
      curl -o /etc/ssh/trusted-user-ca-keys.pem http://vault-ent:8200/v1/ssh-client-signer/public_key
      echo "TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem" | tee -a /etc/ssh/sshd_config
    EOT
    ]
  }

  provisioner "local-exec" {
    command = <<EOT
    docker container restart open-ssh-server
    EOT
  }
  depends_on = [vault_ssh_secret_backend_ca.ssh-client-signer
  ]
}

resource "vault_ssh_secret_backend_role" "admin" {
  name                    = "admin"
  backend                 = vault_mount.ssh-client-signer.path
  key_type                = "ca"
  default_user            = "admin"
  allowed_users           = "*"
  allowed_extensions      = "permit-pty,permit-port-forwarding"
  default_extensions      = { "permit-pty" : "", permit-port-forwarding : "" }
  allow_user_certificates = true
  ttl                     = "60m"
  cidr_list               = "0.0.0.0/0"
}

resource "vault_ssh_secret_backend_role" "sec_ops" {
  name                    = "security_ops"
  backend                 = vault_mount.ssh-client-signer.path
  key_type                = "ca"
  default_user            = "sec_ops"
  allowed_users           = "sec_ops"
  allowed_extensions      = "permit-pty,permit-port-forwarding"
  default_extensions      = { "permit-pty" : "", permit-port-forwarding : "" }
  allow_user_certificates = true
  ttl                     = "60m"
  cidr_list               = "0.0.0.0/0"
}

resource "vault_ssh_secret_backend_role" "backup_ops" {
  name                    = "backup_ops"
  backend                 = vault_mount.ssh-client-signer.path
  key_type                = "ca"
  default_user            = "backup_ops"
  allowed_users           = "backup_ops"
  allowed_extensions      = "permit-pty,permit-port-forwarding"
  default_extensions      = { "permit-pty" : "", permit-port-forwarding : "" }
  allow_user_certificates = true
  ttl                     = "60m"
  cidr_list               = "0.0.0.0/0"
}

resource "vault_policy" "ssh_admin" {
  name   = "ssh-admin"
  policy = <<EOT
path "ssh-client-signer/roles" {
  capabilities = ["list"]
}

path "ssh-client-signer/sign/admin" {
  capabilities = ["update", "create"]
}
EOT
}

resource "vault_policy" "ssh_backup_ops" {
  name   = "ssh-backup-ops"
  policy = <<EOT
path "ssh-client-signer/roles" {
  capabilities = ["list"]
}

path "ssh-client-signer/sign/backup_ops" {
  capabilities = ["update", "create"]
}
EOT
}

resource "vault_policy" "ssh_security_ops" {
  name   = "ssh-sec-ops"
  policy = <<EOT
path "ssh-client-signer/roles" {
  capabilities = ["list"]
}

path "ssh-client-signer/sign/security_ops" {
  capabilities = ["update", "create"]
}
EOT
}
