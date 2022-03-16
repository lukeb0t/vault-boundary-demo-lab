ACTION=$1

if [ "${ACTION}" = "up" ]; then
  terraform -chdir=/Users/lukemccleary/hashi-labs/vault-boundary-demo-lab/docker-infra apply -auto-approve=true && terraform -chdir=/Users/lukemccleary/hashi-labs/vault-boundary-demo-lab/config apply -auto-approve=true
fi

if [ "${ACTION}" = "down" ]; then
  terraform -chdir=/Users/lukemccleary/hashi-labs/vault-boundary-demo-lab/docker-infra apply -destroy -auto-approve=true
  rm /Users/lukemccleary/hashi-labs/vault-boundary-demo-lab/docker-infra/terraform.tfstate*
  rm /Users/lukemccleary/hashi-labs/vault-boundary-demo-lab/config/terraform.tfstate*
fi
