terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "3.2.1"
    }
    boundary = {
      source = "hashicorp/boundary"
      version = "1.0.6"
    }
  }
}