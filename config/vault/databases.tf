resource "vault_mount" "databases" {
  path = "databases"
  type = "database"
}

resource "vault_database_secret_backend_connection" "postgres_connection" {
  backend       = vault_mount.databases.path
  name          = "postgres"
  allowed_roles = ["postgres_dba", "postgres_analyst", "psql_northwind_static"]

  postgresql {
    connection_url       = "postgresql://${var.psql_user}:${var.psql_pw}@${var.psql_host}:${var.psql_port}/${var.psql_root_db}?sslmode=disable"
    max_idle_connections = 100
  }
}

resource "vault_database_secret_backend_connection" "mariadb_connection" {
  backend       = vault_mount.databases.path
  name          = "mariadb"
  allowed_roles = ["maria_dba", "maria_analyst"]

 mysql{
    connection_url = "{{username}}:{{password}}@tcp(${var.mariadb_host}:${var.mariadb_port})/"
    max_idle_connections = 100
  }
  data = {
    username = var.maria_user
    password = var.maria_pw
    }
} 

resource "vault_database_secret_backend_static_role" "psql_static_role" {
  backend             = vault_mount.databases.path
  name                = "psql_northwind_static"
  db_name             = vault_database_secret_backend_connection.postgres_connection.name
  username            = "northwind_static"
  rotation_period     = "3600"
  rotation_statements = ["ALTER USER \"{{name}}\" WITH PASSWORD '{{password}}';"]
}

resource "vault_database_secret_backend_role" "psql_analyst_role" {
  backend     = vault_mount.databases.path
  name        = "postgres_analyst"
  db_name     = vault_database_secret_backend_connection.postgres_connection.name
  default_ttl = 300
  max_ttl     = 3000
  creation_statements = [
    "CREATE ROLE \"{{name}}\" with login password '{{password}}' valid until '{{expiration}}';",
  "GRANT SELECT ON ALL TABLES IN SCHEMA public to \"{{name}}\";"]
  revocation_statements = ["SELECT revoke_access('{{name}}'); DROP user \"{{name}}\";"]
}

resource "vault_database_secret_backend_role" "psql_dba_role" {
  backend     = vault_mount.databases.path
  name        = "postgres_dba"
  db_name     = vault_database_secret_backend_connection.postgres_connection.name
  default_ttl = 300
  max_ttl     = 3000
  creation_statements = ["CREATE ROLE \"{{name}}\" with login password '{{password}}' valid until '{{expiration}}';",
  "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"]
  revocation_statements = ["SELECT revoke_access('{{name}}'); DROP user \"{{name}}\";"]
}

resource "vault_database_secret_backend_role" "maria_analyst_role" {
  backend     = vault_mount.databases.path
  name        = "maria_analyst"
  db_name     = vault_database_secret_backend_connection.mariadb_connection.name
  default_ttl = 300
  max_ttl     = 3000
  creation_statements = ["CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';"]
  
}

resource "vault_database_secret_backend_role" "maria_dba_role" {
  backend     = vault_mount.databases.path
  name        = "maria_dba"
  db_name     = vault_database_secret_backend_connection.mariadb_connection.name
  default_ttl = 300
  max_ttl     = 3000
  creation_statements = ["CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL PRIVILEGES ON *.* TO '{{name}}'@'%';"]
}

