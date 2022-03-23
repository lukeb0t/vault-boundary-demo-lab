terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.3.1"
      configuration_aliases = [ vault.finance ]
    }
  }
}
