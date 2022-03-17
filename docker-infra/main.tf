provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "vault" {
  name = "hashicorp/vault-enterprise:latest"
}

resource "docker_image" "psql" {
  name = "postgres"
}

resource "docker_image" "maria" {
  name = "mariadb"
}

resource "docker_image" "boundary" {
  name = "hashicorp/boundary:latest"
}

# resource "docker_image" "ssh-otp" {
#  name = "luke/ssh_helper:latest"
# }

resource "docker_network" "network" {
  name = "demo_net"
}

resource "docker_container" "vault" {
  name       = var.vault_hostname
  hostname   = var.vault_hostname
  networks   = [docker_network.network.name]
  image      = docker_image.vault.latest
  privileged = true
  env = ["VAULT_ADDR=http://127.0.0.1:8200", "VAULT_LICENSE=${var.vault_license}", "VAULT_DEV_ROOT_TOKEN_ID=root"]
  ports {
    internal = 5696
    external = 5696
  }
  ports {
    internal = 8200
    external = var.ext_vault_port
  }
  capabilities {
    add = ["IPC_LOCK"]
  }
}

resource "docker_container" "psql" {
  name     = "postgres-sql"
  hostname = var.psql_hostname
  networks = [docker_network.network.name]
  image    = docker_image.psql.latest
  env      = ["POSTGRES_PASSWORD=postgres", "POSTGRES_USER=postgres"]
  ports {
    internal = 5432
    external = var.ext_psql_port
  }

  provisioner "local-exec" {
    command = <<EOT
  sleep 3
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/postgres" -c 'create database boundary_clean'
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/postgres" -c 'create database northwind'
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/northwind" -f northwind-database.sql --quiet
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/northwind" -f northwind-roles.sql --quiet
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/postgres" -c "CREATE USER northwind_static WITH PASSWORD 'root';"
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/postgres" -c "ALTER USER northwind_static WITH SUPERUSER;"
  EOT
  }
}

resource "docker_container" "maria_db" {
  name     = "maria-db"
  hostname = var.mariadb_hostname
  networks = [docker_network.network.name]
  image    = docker_image.maria.latest
  env      = ["MYSQL_ROOT_PASSWORD=root"]
  ports {
    internal = 3306
    external = var.ext_maria_port
  }
  provisioner "local-exec" {
    command = <<EOT
  sleep 10
  mysql -h 127.0.0.1 --port ${var.ext_maria_port} -uroot -proot < ./maria.sql
  EOT
  }
}

resource "docker_container" "boundary_init" {
  name       = "boundary_init"
  hostname   = "boundary_init"
  networks   = [docker_network.network.name]
  privileged = true
  image      = docker_image.boundary.latest
  env        = ["BOUNDARY_POSTGRES_URL=postgresql://postgres:postgres@postgres-sql/boundary_clean?sslmode=disable"]
  command    = ["database", "init", "-skip-initial-login-role-creation", "-config", "boundary/config.hcl"]
  depends_on = [
    docker_container.psql
  ]
  provisioner "local-exec" {
    command = "sleep 3"
  }
}

resource "docker_container" "boundary_serv" {
  name       = "boundary_serv"
  hostname   = "boundary_serv"
  networks   = [docker_network.network.name]
  privileged = true
  image      = docker_image.boundary.latest
  env        = ["BOUNDARY_POSTGRES_URL=postgresql://postgres:postgres@postgres-sql/boundary_clean?sslmode=disable"]

  ports {
    internal = 9200
    external = var.boundary_ui_port
  }
  ports {
    internal = 9201
    external = var.boundary_worker_port
  }
  ports {
    internal = 9202
    external = var.boundary_other_port
  }
   
  depends_on = [
    docker_container.boundary_init
  ]
}
# resource "docker_container" "ssh-otp" {
#   name       = "ssh-otp"
#   hostname   = "ssh-otp"
#   rm = false
#   networks   = [docker_network.network.name]
#   image      = docker_image.ssh-otp.latest
#   privileged = true
#   env = ["VAULT_ADDR=http://vault-ent:8200", "NS=finance"]
#   ports {
#     internal = 22
#     external = 8005
#   }
#    depends_on = [
#     docker_container.vault
#   ]
# }