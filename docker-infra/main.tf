provider "docker" {
  host = "unix:///var/run/docker.sock"
}

data "docker_registry_image" "vault" {
  name = "hashicorp/vault-enterprise:latest"
}

data "docker_registry_image" "psql" {
  name = "postgres:latest"
}

data "docker_registry_image" "maria" {
  name = "mariadb:latest"
}

data "docker_registry_image" "boundary" {
  name = "hashicorp/boundary:latest"
}

resource "docker_image" "vault" {
  name = data.docker_registry_image.vault.name
  pull_triggers = [data.docker_registry_image.vault.sha256_digest]
}

resource "docker_image" "psql" {
  name = data.docker_registry_image.psql.name
  pull_triggers = [data.docker_registry_image.psql.sha256_digest]
}

resource "docker_image" "maria" {
  name = data.docker_registry_image.maria.name
  pull_triggers = [data.docker_registry_image.maria.sha256_digest]
}

resource "docker_image" "boundary" {
  name = data.docker_registry_image.boundary.name
  pull_triggers = [data.docker_registry_image.boundary.sha256_digest]
}

resource "docker_image" "open-ssh-server" {
  name = "lscr.io/linuxserver/openssh-server:latest"
}

resource "docker_network" "network" {
  name = "demo_net"
}

resource "docker_container" "open-ssh-server" {
  name       = var.open-ssh-server-name
  hostname   = var.open-ssh-server-name
  image      = docker_image.open-ssh-server.name
  privileged = true
  restart    = "unless-stopped"
  env        = ["SUDO_ACCESS=true", "USER_NAME=admin", "USER_PASSWORD=Hashi123#", "PASSWORD_ACCESS=true"]
networks_advanced {
    name = docker_network.network.id
  }
  ports {
    internal = 2222
    external = 2222
  }
}

resource "docker_container" "vault-agent" {
  name       = var.vault-agent-hostname
  hostname   = var.vault-agent-hostname
  image      = docker_image.open-ssh-server.name
  privileged = true
  restart    = "unless-stopped"
  env        = ["SUDO_ACCESS=true", "USER_NAME=admin", "USER_PASSWORD=Hashi123#", "PASSWORD_ACCESS=true"]
  networks_advanced {
    name = docker_network.network.id
  }
  ports {
    internal = 2222
    external = 2020
  }
}

resource "docker_container" "vault" {
  name       = var.vault_hostname
  hostname   = var.vault_hostname
  image      = docker_image.vault.name
  privileged = true
  env        = ["VAULT_ADDR=http://127.0.0.1:8200", "VAULT_LICENSE=${var.vault_license}", "VAULT_DEV_ROOT_TOKEN_ID=root"]
  networks_advanced {
    name = docker_network.network.id
  }
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
  image    = docker_image.psql.name
  env      = ["POSTGRES_PASSWORD=postgres", "POSTGRES_USER=postgres"]
  
  provisioner "local-exec" {
    command = <<EOT
  sleep 15
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/postgres" -c 'create database boundary_clean'
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/postgres" -c 'create database northwind'
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/northwind" -f ./files/northwind-database.sql --quiet
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/northwind" -f ./files/northwind-roles.sql --quiet
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/postgres" -c "CREATE USER northwind_static WITH PASSWORD 'root';"
  psql "postgresql://postgres:postgres@localhost:${var.ext_psql_port}/postgres" -c "ALTER USER northwind_static WITH SUPERUSER;"
  EOT
  }

  networks_advanced {
    name = docker_network.network.id
  }

  ports {
    internal = 5432
    external = var.ext_psql_port
  }

}

resource "docker_container" "maria_db" {
  name     = "maria-db"
  hostname = var.mariadb_hostname
  image    = docker_image.maria.name
  env      = ["MYSQL_ROOT_PASSWORD=root"]
  networks_advanced {
    name = docker_network.network.id
  }
  ports {
    internal = 3306
    external = var.ext_maria_port
  }
  provisioner "local-exec" {
    command = <<EOT
  sleep 10
  mysql -h 127.0.0.1 --port ${var.ext_maria_port} -uroot -proot < ./files/maria.sql
  EOT
  }
}

resource "docker_container" "boundary_init" {
  name       = "boundary_init"
  hostname   = "boundary_init"
  privileged = true
  rm = true #automatically remove init container once it exits
  image      = docker_image.boundary.name
  env        = ["BOUNDARY_POSTGRES_URL=postgresql://postgres:postgres@postgres-sql/boundary_clean?sslmode=disable"]
  command    = ["database", "init", "-skip-initial-login-role-creation", "-config", "boundary/config.hcl"]
  
  depends_on = [
    docker_container.psql
  ]
  provisioner "local-exec" {
    command = "sleep 3"
  }
  networks_advanced {
    name = docker_network.network.id
  }
}

resource "docker_container" "boundary_serv" {
  name       = "boundary_serv"
  hostname   = "boundary_serv"
  privileged = true
  image      = docker_image.boundary.name
  env        = ["BOUNDARY_POSTGRES_URL=postgresql://postgres:postgres@postgres-sql/boundary_clean?sslmode=disable"]
  
  networks_advanced {
    name = docker_network.network.id
  }
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
