
# This Terraform module will rollout the following Vault config for demos:
  - Namespaces
  - Postgres integration (dynamic and static credentials)
  - MariaDB integration (dynamic credentials)
  - PKI Root CA
  - PKI Intermediate CA
  - Basic SSH Engine (No operational demo)
  - Approle Auth with a policy to retreived a basic KV secret
  - Transform Secrets Engine

# Requirements:
  - Running instance of Vault *Enterprise*
  - Running instance of Postgres SQL
  - Running instance of MariaDB

## TODO
- [ ] Merge this project with the related docker infrastucture terraform module
- [ ] Add inline comments to code
- [ ] Re-integrate Boundary demo code