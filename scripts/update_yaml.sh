# This file is used to upgrade the Version value from given jenkins version and auto push the upadate file to bitbucket and then helm will upgrade pods in kubernetes cluster.
# INSTANCE_NAME and VERSION values we are getting from build with parameters in jenkins.

#!/bin/bash
. ./scripts/env_variables.sh

# Convert VERSION jenkins variable value to lower case to update the value in ${INSTANCE_NAME}.yaml
lower_version=$(echo "${VERSION}" | tr '[:upper:]' '[:lower:]')

instanceFile=${WORKSPACE}/helm/environments/${ENV_TYPE}/${INSTANCE_NAME}.yaml

if [ -f "$instanceFile" ]; then
    mono_deployment_name=$(cat "$instanceFile" | grep mono-deployment-name)
    orbit_home_sync_image=$(cat "$instanceFile" | grep orbit_home_sync_image)

    updated_mono_deployment_name="mono-deployment-name : $INSTANCE_NAME-$lower_version"
    updated_orbit_sync_name="orbit_home_sync_image : bom.ocir.io/idgrosnf0lwv/orbit-int-repo/orbit_home_sync:${VERSION}"

    # Add leading spaces to lower version to update values in ${INSTANCE_NAME}.yaml
    mono_name_lower_version=$(printf "%*s%s" 8 '' "$updated_mono_deployment_name")
    orbit_image_updated_version=$(printf "%*s%s" 8 '' "$updated_orbit_sync_name")
    
    # SED command to replace exisitng line with newly updated line in ${INSTANCE_NAME}.yaml
    sed -i "s/$mono_deployment_name/$mono_name_lower_version/g" "$instanceFile"
    sed -ie "s@$orbit_home_sync_image@$orbit_image_updated_version@" "$instanceFile"
fi

if [ -f "${WORKSPACE}/helm/environments/${ENV_TYPE}/${INSTANCE_NAME}.yamle" ]; then
    rm -rf ${WORKSPACE}/helm/environments/${ENV_TYPE}/${INSTANCE_NAME}.yamle
fi

# git commands to auto push files to updated ${INSTANCE_NAME}.yaml to bitbucket
git add --all :/
git status
git commit -am "Changed files, Auto-Commit V0.1"
git branch $BRANCH_NAME
git push -f -u origin $BRANCH_NAME
