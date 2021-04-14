#!/bin/bash
. ./scripts/env_variables.sh
cd terraform
cp -r ${WORKSPACE}/terraform/tf_environment/${ENV_TYPE}/${INSTANCE_NAME}/* ${WORKSPACE}/terraform/tf_environment
cp -r ${WORKSPACE}/terraform/tf_environment/${ENV_TYPE}/${INSTANCE_NAME}/.terraform ${WORKSPACE}/terraform/tf_environment
make destroy NameSpace=${INSTANCE_NAME}
rm -rf ${WORKSPACE}/terraform/tf_environment/${ENV_TYPE}/${INSTANCE_NAME}

if [ -f "${WORKSPACE}/terraform/tf_environment/${ENV_TYPE}/${INSTANCE_NAME}.yaml" ]; then
	rm -rf ${WORKSPACE}/helm/environments/${ENV_TYPE}/${INSTANCE_NAME}.yaml
fi

rm -rf ./tf_environment/.terraform ./tf_environment/terraform.*

# git commands to auto push the ${INSTANCE_NAME}.yaml to master branch
git add --all :/
git status
git commit -am "Changed files, Auto-Commit V0.1"
git branch $BRANCH_NAME
git push -f -u origin $BRANCH_NAME
