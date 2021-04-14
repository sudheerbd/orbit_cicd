#!/bin/bash
. ./scripts/env_variables.sh

instance_name=${INSTANCE_NAME}
current_version=$(echo "${VERSION}" | tr '[:upper:]' '[:lower:]')
instanceFile=${WORKSPACE}/helm/environments/${ENV_TYPE}/${INSTANCE_NAME}.yaml
if [ -f "$instanceFile" ]; then
   mono_deployment_name=$(cat "$instanceFile" | grep mono-deployment-name)
   mono_deployment_name_trimmed=$(echo $mono_deployment_name | sed 's/ *$//g')
   exist_version=$(echo $mono_deployment_name_trimmed | sed "s/mono-deployment-name : $instance_name-orbit//g")
   cur_version=${current_version//[^0-9.]/}
   previous_version=$(echo $mono_deployment_name_trimmed | sed "s/mono-deployment-name : $instance_name-//g")
   if [ "$(printf '%s\n' "$exist_version" "$cur_version" | sort -V | head -n1)" = "$exist_version" ]; then
      ${WORKSPACE}/scripts/update_yaml.sh
      cd ${WORKSPACE}/orbit-deployer
      go run main.go deploy -e ${INSTANCE_NAME} -t=${ENV_TYPE} "mono:${VERSION}"
      if [[ $? -ne 0 ]]
      then
         exit 1  
      fi
      kubectl delete deployment $INSTANCE_NAME-$previous_version -n $INSTANCE_NAME
      # git commands to auto push files to updated ${INSTANCE_NAME}.yaml to bitbucket
      git add --all :/
      git status
      git commit -am "Changed files, Auto-Commit V0.1"
      git branch $BRANCH_NAME
      git push -f -u origin $BRANCH_NAME
   else
      echo "Version not upgraded either same version or lower version was selected"
   fi
fi
