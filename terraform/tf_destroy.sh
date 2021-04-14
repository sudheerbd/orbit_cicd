# This file is used to destroy the terraform created resources by create instance job.

#!/bin/bash
. ./scripts/env_variables.sh

cd terraform/tf_environment
cp -r ${WORKSPACE}/terraform/tf_environment/${ENV_TYPE}/${INSTANCE_NAME}/* ${WORKSPACE}/terraform/tf_environment
terraform init

if [ -f "/tmp/subnet.txt" ]; then
    sub_ocid=$(cat /tmp/subnet.txt)
    terraform destroy -var "file_system_name=${INSTANCE_NAME}" -var "export_path=/${INSTANCE_NAME}" -var "subnet_ocid=$sub_ocid" -lock=false -auto-approve
else 
    subOcid=""
    terraform destroy -var "file_system_name=${INSTANCE_NAME}" -var "export_path=/${INSTANCE_NAME}" -var "subnet_ocid=$sub_ocid" -lock=false -auto-approve
fi

rm -rf ./${ENV_TYPE}/${INSTANCE_NAME}
rm -rf ${WORKSPACE}/helm/environments/${ENV_TYPE}/${INSTANCE_NAME}.yaml
rm -rf ./.terraform ./terraform.*

# Delete subnet using terraform
if [ -f "/tmp/subnet.txt" ]; then
    cd ${WORKSPACE}/terraform/subnet
    terraform init
    cp -r ./${ENV_TYPE}/${INSTANCE_NAME}/* ${WORKSPACE}/terraform/subnet
    terraform destroy -var "subnet_name=${INSTANCE_NAME}" -lock=true -auto-approve
    rm -rf ./${ENV_TYPE}/${INSTANCE_NAME}
    rm -rf ./.terraform ./terraform.*
    rm -rf /tmp/cidr_file.txt /tmp/dynamic_cidr.txt /tmp/subnet.txt
fi
    
# git commands to auto push files to bitbucket
git add --all :/
git status
git commit -am "Changed files, Auto-Commit V0.1"
git branch $BRANCH_NAME
git push -f -u origin $BRANCH_NAME
