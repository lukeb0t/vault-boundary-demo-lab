#!/bin/bash

echo "setting up vault"

# Generate config for vault-ssh-helper
mkdir -p /etc/vault-ssh-helper.d/
cat << EOF > /etc/vault-ssh-helper.d/config.hcl
vault_addr = "http://vault-ent:8200"
ssh_mount_point = "ssh"
namespace = "finance"
tls_skip_verify = true
allowed_roles = "*"
allowed_cidr_list="0.0.0.0/0"
EOF

# # Set PAMD
# sed -i -e 's/^@include common-auth/#@include common-auth/g' /etc/pam.d/sshd 
# echo "auth requisite pam_exec.so quiet expose_authtok log=/var/log/vault-ssh.log /usr/local/bin/vault-ssh-helper -dev -config=/etc/vault-ssh-helper.d/config.hcl" | tee -a /etc/pam.d/sshd
# echo "auth optional pam_unix.so not_set_pass use_first_pass nodelay" | tee -a /etc/pam.d/sshd
# 
# 
# sed -i -e 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config # enable ChallengeResponseAuthentication
# sed -i -e 's/UsePAM no/UsePAM yes/g' /etc/ssh/sshd_config # enable PAM usage
# sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config # disable cleartext tunneling of passwords

service ssh stop
service ssh start

curl http://vault-ent:8200/v1/sys/health

echo "ssh helper config:"
cat /etc/vault-ssh-helper.d/config.hcl

# The helper needs to be started in dev mode because
# TLS was disabled in Vault's config
vault-ssh-helper -dev -config /etc/vault-ssh-helper.d/config.hcl
sleep 5
cat /var/log/vault-ssh.log

