terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      configuration_aliases = [ vault.finance ]
    }
    random = {
      source = "hashicorp/random"
      version = "3.3.2"
    }
  }
}
