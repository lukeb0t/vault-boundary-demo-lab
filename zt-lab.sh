ACTION=$1
WORKDIR=$(pwd)

INFRA_PATH="${WORKDIR}/docker-infra"
CONFIG_PATH="${WORKDIR}/config"


if [ "${ACTION}" = "up" ]; then
  terraform -chdir=$INFRA_PATH apply -auto-approve=true && terraform -chdir=$CONFIG_PATH apply -auto-approve=true
fi

if [ "${ACTION}" = "down" ]; then
  terraform -chdir=$INFRA_PATH apply -destroy -auto-approve=true
  rm $INFRA_PATH/terraform.tfstate*
  rm $CONFIG_PATH/terraform.tfstate*
fi

if [ "${ACTION}" = "plan" ]; then
  terraform -chdir=$INFRA_PATH plan
fi

if [ "${ACTION}" = "upgrade" ]; then
  terraform -chdir=$CONFIG_PATH init -upgrade && terraform -chdir=$INFRA_PATH init -upgrade
fi