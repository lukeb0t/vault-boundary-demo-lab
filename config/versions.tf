terraform {
  required_providers {
    boundary = {
      source = "hashicorp/boundary"
      version = "1.0.6"
    }
    vault = {
      source = "hashicorp/vault"
    } 
    random = {
      source = "hashicorp/random"
      version = "3.3.2"
    }  
}
}