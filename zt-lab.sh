ACTION=$1
WORKDIR=$(pwd)


if [ "${ACTION}" = "up" ]; then
  terraform -chdir=${WORKDIR}/docker-infra init && terraform -chdir=-chdir=${WORKDIR}/config init
  terraform -chdir=${WORKDIR}/docker-infra apply -auto-approve=true && terraform -chdir=/Users/lukemccleary/hashi-labs/vault-boundary-demo-lab/config apply -auto-approve=true
fi

if [ "${ACTION}" = "down" ]; then
  terraform -chdir=${WORKDIR}/docker-infra apply -destroy -auto-approve=true
  rm ${WORKDIR}/docker-infra/terraform.tfstate*
  rm ${WORKDIR}/config/terraform.tfstate*
fi

