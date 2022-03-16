# This project contains the terrafrom modules needed to rollout both the docker infrastracture and Hashicorp product configuration to demo Vault and Boundary

## Requirements
- Terraform >1.0
- Docker
- Vault Enterprise License Key
- Some other stuff I probably forgot but thats what error handling is for
## Vault Configuration
- Namespaces
- Postgres integration (dynamic and static credentials)
- MariaDB integration (dynamic credentials)
- PKI Root CA
- PKI Intermediate CA
- Basic SSH Engine (No operational demo, yet)
- Approle Auth with a policy to retreived a basic KV secret (approle creds are a TF output)
- Transform Secrets Engine (tranformation data is a TF output)

## Boundary Configuration
- Demo Organizational Scopes
- User, Roles, and Groups
- Credential Library integrated with Hashicorp Vault
- Demo Host Sets and Targets
- SSH Target (No operational demo, yet)

## Deployment Instructions:

  1. Create an auto.fvars file in the 'docker-infra' directory.
  2. Add the only required variable: 'vault_license={yourkey}....'
  1. Create an auto.fvars file in the root 'docker-infra' directory
  2. Add your License to the "vault_license.auto.tfvars" file
  4. To trigger both workspaces creation and destruction: use commands 'sh ztlab up' and 'sh ztlab down'


## TODO
- [ ] Improve inline documentation
- [ ] Add lab for SSH OTP
