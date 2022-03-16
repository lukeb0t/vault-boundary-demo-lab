# This project contains the terrafrom modules needed to rollout both the docker infrastracture and Hashicorp product configuration to demo Vault and Boundary

## Requirements
- Terraform >1.0
- Docker
- Vault Enterprise License Key (with all features enabled)
- mysql command line tool
- psql command line tool
    - If you install with Brew, you MUST also create a new user "/usr/local/opt/postgres/bin/createuser -s postgres"
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
  
  1. Add your License to the "vault_license.auto.tfvars" file
  2. Add the only required variable: 'vault_license={yourkey}....'
  3. To trigger both workspaces creation and destruction: use commands 'sh ztlab up' and 'sh ztlab down'


- [ ] Improve inline documentation
- [ ] Add lab for SSH OTP
- [ ] outputs for vault and boundary logins
- [ ] outputs for vault and boundary address
- [ ] fixed the enable OIDC in config/main to false by default
- [ ] review variable usage in infra module