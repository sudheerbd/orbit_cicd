# This file is used to destroy the terraform created resources by create instance job.

#!/bin/bash
. ./scripts/env_variables.sh

cd terraform/tf_environment
cp -r ${WORKSPACE}/terraform/tf_environment/${ENV_TYPE}/${INSTANCE_NAME}/terraform.* ${WORKSPACE}/terraform/tf_environment
cp ${WORKSPACE}/terraform/tf_environment/${ENV_TYPE}/${INSTANCE_NAME}/cidr_file.txt $cidr_file
cp ${WORKSPACE}/terraform/tf_environment/${ENV_TYPE}/${INSTANCE_NAME}/dynamic_cidr.txt $dynamic_cidr_file

terraform init
terraform destroy -var "customer_name=${INSTANCE_NAME}" -var "export_path=/${INSTANCE_NAME}" -var "need_subnet=${NEED_SUBNET}" -lock=false -auto-approve
rm -rf ./${ENV_TYPE}/${INSTANCE_NAME}
rm -rf ${WORKSPACE}/helm/environments/${ENV_TYPE}/${INSTANCE_NAME}.yaml
rm -rf ./.terraform* ./terraform.*
rm -rf $cidr_file $dynamic_cidr_file

## git commands to auto push files to bitbucket
git add --all :/
git status
git commit -am "Changed files, Auto-Commit V0.1"
git branch $BRANCH_NAME
git push -f -u origin $BRANCH_NAME
