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

## Deployment Instructions:

Manual Option:

  1. Install Docker / Docker Desktop + Terraform >1.0
  2. Customize the terraform module in the 'docker-infra' directory as needed (set the Vault license variable at the minimum)
  3. Apply the docker-infra module
  4. Customize the terraform module in the 'config' directory as needed
  5. Apply the config module

Scripted Option:

  1. Create an auto.fvars file in the root 'docker-infra' directory.
  2. Add the only required variable: 'vault_license={yourkey}....'
  4. To trigger both workspaces creation and destruction: use commands 'sh ztlab up' and 'sh ztlab down'


## TODO
- [ ] Improve inline documentation
- [ ] Add lab for SSH OTP
