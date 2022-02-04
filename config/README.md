
# Demo Config for Hashicorp's Vault and Boundary Products

## Requirements
- See the 'infra' terraform module at the root of this project
- Terraform >1.0
- Running instances of:
  - Hashicorp Vault *Enterprise* (requires a license key)
  - Hashicorp Boundary
  - Postgres DB
  - Maria DB
## Vault Configuration
- Namespaces
- Postgres integration (dynamic and static credentials)
- MariaDB integration (dynamic credentials)
- PKI Root CA
- PKI Intermediate CA
- Basic SSH Engine (No operational demo)
- Approle Auth with a policy to retreived a basic KV secret
- Transform Secrets Engine

## Boundary Configuration
- Demo Organizational Scopes
- User, Roles, and Groups
- Credential Library integrated with Hashicorp Vault
- Demo Host Sets and Targets

## TODO
- [ ] Add inline comments to code