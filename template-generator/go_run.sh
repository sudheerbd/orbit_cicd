#!/bin/bash
. ./scripts/env_variables.sh
username=${INSTANCE_NAME}
password="${username:0:3}Orbit#1234"
lower_version=$(echo "${VERSION}" | tr '[:upper:]' '[:lower:]')


if [ ! -d "${WORKSPACE}/helm/environments/${ENV_TYPE}" ] 
then
    mkdir -p ${WORKSPACE}/helm/environments/${ENV_TYPE}
    chmod 755 ${WORKSPACE}/helm/environments/${ENV_TYPE}
fi


cd ${WORKSPACE}/template-generator
go run go-cli-template.go --namespace=${INSTANCE_NAME} --language=${LANGUAGE} --user=$username --pwd=$password --orbit_home_sync_image=${VERSION} --deployment_image_name=$lower_version --mount_target_ip=$mount_target_ip template.yaml > ${WORKSPACE}/helm/environments/${ENV_TYPE}/${INSTANCE_NAME}.yaml
if [[ $? -ne 0 ]]
then
   exit 1  
fi
chmod 644 ${WORKSPACE}/helm/environments/${ENV_TYPE}/${INSTANCE_NAME}.yaml

cd ${WORKSPACE}/orbit-deployer
go run main.go deploy -e ${INSTANCE_NAME} -t=${ENV_TYPE} -c=true mono:${VERSION}
if [[ $? -ne 0 ]]
then
   exit 1  
fi
sleep 300
deployment=$(/usr/local/bin/kubectl get deployment -n ${INSTANCE_NAME} | awk 'FNR == 2 {print $1}')
deploy_status=$(/usr/local/bin/kubectl get deployment -n ${INSTANCE_NAME} | awk 'FNR == 2 {print $2}')
pod_status=$(/usr/local/bin/kubectl get pod -n ${INSTANCE_NAME} | awk 'FNR == 2 {print $2}')
if [ $deploy_status = "1/1" ]
then
    echo "Deployment Succes"
    if [ $pod_status = "1/1" ]
    then
        echo "pod success"
        /usr/local/bin/kubectl autoscale deployment  $deployment -n ${INSTANCE_NAME}  --cpu-percent=50 --min=1 --max=5
        git add --all :/
        git status
        git commit -am "Changed files, Auto-Commit V0.1"
        git branch $BRANCH_NAME
        git push -f -u origin $BRANCH_NAME
    else
        echo "pod failed"
        exit 1
    fi
else
    echo "Deployment failed"
    sleep 250
    exit 1
fi
