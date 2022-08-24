terraform {
  required_providers {
    boundary = {
      source = "hashicorp/boundary"
      version = "1.0.6"
    }
      vault = {
      source = "hashicorp/vault"
    }
  }
}