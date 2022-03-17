# This project contains the terrafrom modules needed to rollout both the docker infrastracture and Hashicorp product configuration to demo Vault and Boundary

## Requirements
- Terraform >1.0
- Docker
- Vault Enterprise License Key (with all features enabled)
- mysql command line tool
- psql command line tool
- Some other stuff I probably forgot but thats what error handling is for
## Vault Configuration
- Namespaces
- Postgres integration (dynamic and static credentials)
- MariaDB integration (dynamic credentials)
- PKI Root CA (hashidemo.com)
- PKI Intermediate CA (*.hashidemo.com)
- Basic SSH Engine (No operational demo, yet)
- Approle Auth with a policy to retreived a basic KV secret (approle creds are a TF output)
- Transform Secrets Engine (tranformation data is a TF output)

## Boundary Configuration
- OIDC (Requires additional parameters @ /config/boundary/main.tf:line67+, disable on line 67 if not in use)
- Demo Organizational Scopes
- User, Roles, and Groups
- Credential Library integrated with Hashicorp Vault
- Demo Host Sets and Targets
- SSH Target (No operational demo, yet)

## Deployment Instructions:
  
  1. Review all your port usage to ensure no overlap (All of the these defaults can be changed in /docker-infra/vars.tf)
    - Vault @ 8211
    - Boundary @ 9211
    - PSQL @ 5433
    - MySQL @ 3307

  2. Add your License to the "vault_license.auto.tfvars" file
  3. Add the only required variable: 'vault_license={yourkey}....'
  4. To trigger both workspaces creation and destruction: use commands 'sh ztlab up' and 'sh ztlab down'


## TODO:
- [ ] Improve inline documentation
- [ ] Add lab for SSH OTP
- [ ] review variable usage in infra module