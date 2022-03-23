ACTION=$1
WORKDIR=$(pwd)

INFRA_PATH="${WORKDIR}/docker-infra"
CONFIG_PATH="${WORKDIR}/config"


if [ "${ACTION}" = "up" ]; then
  terraform -chdir=$INFRA_PATH apply -auto-approve=true && terraform -chdir=$CONFIG_PATH apply -auto-approve=true
fi

if [ "${ACTION}" = "down" ]; then
  terraform -chdir=$CONFIG_PATH apply -destroy -auto-approve=true
  rm $CONFIG_PATH/terraform.tfstate*
  rm $CONFIG_PATH/terraform.tfstate*
fi

if [ "${ACTION}" = "plan" ]; then
  terraform -chdir=$CONFIG_PATH plan && terraform -chdir=$CONFIG_PATH plan
fi

if [ "${ACTION}" = "upgrade" ]; then
  terraform -chdir=$CONFIG_PATH init -upgrade && terraform -chdir=$CONFIG_PATH init -upgrade
fi