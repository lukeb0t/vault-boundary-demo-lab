VAULT_ADDR=http://127.0.0.1:8200
VAULT_TOKEN=root
vault login root
vault secrets enable kmip
vault write kmip/config listen_addrs=0.0.0.0:5696
vault read kmip/ca
vault read -format=json kmip/ca | jq -r .data.ca_pem > ca.pem
vault write -f kmip/scope/finance
vault write kmip/scope/finance/role/mongodb_tde operation_all=true
vault read kmip/scope/finance/role/mongodb_tde