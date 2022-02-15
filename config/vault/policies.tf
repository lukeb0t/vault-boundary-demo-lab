resource "vault_policy" "northwind_static_policy" {
  name   = "northwind_static_policy"
  policy = <<EOT
path "database/static-creds/psql_static" {
  capabilities = [ "read" ]
}
EOT
}

resource "vault_policy" "fpe-client-policy" {
  name   = "fpe-client-policy"
  policy = <<EOT
  path "transform/encode/*" {
   capabilities = [ "update" ]
}

path "transform/decode/*" {
   capabilities = [ "update" ]
}
EOT
}

resource "vault_policy" "admin_policy_finance" {
  provider   = vault.finance
  name       = "admins"
  policy     = file("vault/policies/admin.hcl")
}

resource "vault_policy" "admin-policy" {
  name   = "admin"
  policy = file("vault/policies/admin.hcl")
}


### Boundary Policies
resource "vault_policy" "controller_policy" {
  name   = "boundary_controller_policy"
  policy = <<EOT
  path "auth/token/lookup-self" {
  capabilities = ["read"]
}
path "auth/token/renew-self" {
  capabilities = ["update"]
}
path "auth/token/revoke-self" {
  capabilities = ["update"]
}
path "sys/leases/renew" {
  capabilities = ["update"]
}
path "sys/leases/revoke" {
  capabilities = ["update"]
}
path "sys/capabilities-self" {
  capabilities = ["update"]
}
EOT
}

resource "vault_policy" "northwind_db_policy" {
  name   = "northwind_db_policy"
  policy = <<EOT
path "databases/creds/postgres_analyst" {
  capabilities = ["read"]
}

path "databases/creds/postgres_dba" {
  capabilities = ["read"]
}
EOT
}


resource "vault_token" "boundary" {
  policies          = [vault_policy.northwind_db_policy.name, vault_policy.controller_policy.name]
  renewable         = true
  no_parent         = true
  period            = "20m"
  no_default_policy = true
}