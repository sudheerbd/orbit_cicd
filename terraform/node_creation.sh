#!/bin/bash
. ./scripts/env_variables.sh
cd terraform/node_creation
terraform init
terraform plan -out=terraform.tfplan
terraform apply -var "node_name=${INSTANCE_NAME}" -lock=true -auto-approve
mkdir -p ./${ENV_TYPE}/${INSTANCE_NAME}
chmod 755 ./${ENV_TYPE}/${INSTANCE_NAME}
cp -r ./terraform.tfplan ./${ENV_TYPE}/${INSTANCE_NAME}
cp -r ./terraform.tfstate ./${ENV_TYPE}/${INSTANCE_NAME}
cp -r ./.terraform ./${ENV_TYPE}/${INSTANCE_NAME}
rm -rf ./.terraform ./terraform.tfplan ./terraform.tfstate