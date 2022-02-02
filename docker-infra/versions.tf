terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "2.24.1"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}
