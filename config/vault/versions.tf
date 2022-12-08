terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"

      configuration_aliases = [vault.finance]
    }
  }
}
