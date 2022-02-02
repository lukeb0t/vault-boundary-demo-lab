# This project contains the terrafrom modules needed to rollout both the docker infrastracture and Hashicorp product configuration to demo Vault and Boundary
## Instructions:

  1. Install Docker / Docker Desktop
  2. Customize the terraform module in the 'docker-infra' directory as needed (you'll need a Vault enterprise license at the minimum)
  3. Apply the docker-infra module
  4. Customize the terraform module in the 'docker-infra' directory as needed
  5. Apply the config module