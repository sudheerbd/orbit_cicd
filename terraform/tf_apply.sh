#!/bin/bash
. ./scripts/env_variables.sh
cd terraform

if [ -f "/tmp/subnet.txt" ]; then
    sub_ocid=$(cat /tmp/subnet.txt)
    make apply NameSpace=${INSTANCE_NAME} subOcid=$sub_ocid
    if [[ $? -ne 0 ]]
    then
        exit 1  
    fi
else 
    make apply NameSpace=${INSTANCE_NAME} subOcid=""
    if [[ $? -ne 0 ]]
    then
        exit 1  
    fi
fi 

# Terrafrom commands added in makefile to run terraform init,plan and apply to create resources.
mkdir -p ./tf_environment/${ENV_TYPE}/${INSTANCE_NAME}
chmod 755 ./tf_environment/${ENV_TYPE}/${INSTANCE_NAME}
cp -r ./tf_environment/terraform.tfplan ./tf_environment/${ENV_TYPE}/${INSTANCE_NAME}
cp -r ./tf_environment/terraform.tfstate ./tf_environment/${ENV_TYPE}/${INSTANCE_NAME}
rm -rf ./tf_environment/.terraform ./tf_environment/terraform.tfplan ./tf_environment/terraform.tfstate
