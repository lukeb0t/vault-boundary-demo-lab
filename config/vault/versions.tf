terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.2.0"
    }
  }
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.0.5"
    }
  vault  = {
    source = "hashicorp/vault"
  }
}