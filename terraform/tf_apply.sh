#!/bin/bash
. ./scripts/env_variables.sh
cd terraform/tf_environment

terraform get -update
terraform init
terraform fmt
terraform validate
terraform plan -out=terraform.tfplan
terraform apply -var "customer_name=${INSTANCE_NAME}" -var "export_path=/${INSTANCE_NAME}" -var "need_subnet=${NEED_SUBNET}" -lock=false -auto-approve

mkdir -p ./${ENV_TYPE}/${INSTANCE_NAME}
chmod 755 ./${ENV_TYPE}/${INSTANCE_NAME}
cp -r ./terraform.tfplan ./${ENV_TYPE}/${INSTANCE_NAME}
cp -r ./terraform.tfstate ./${ENV_TYPE}/${INSTANCE_NAME}
rm -rf ./.terraform* ./terraform*

if [[ -f $cidr_file && -f $dynamic_cidr_file ]]; then
    cp  $cidr_file $dynamic_cidr_file ./${ENV_TYPE}/${INSTANCE_NAME}
fi

rm -rf $cidr_file $dynamic_cidr_file
