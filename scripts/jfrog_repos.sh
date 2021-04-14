#!/bin/bash
. ./scripts/env_variables.sh

jfrog_url="http://$jfrog_ipaddress:$jfrog_port/artifactory/api/storage/orbit-releases/"

# Command to get the vesrions from jfrog artifactory and dynamically update version in choice parameters for jenkins jobs.
curl -u $jfrog_username:$jfrog_encry_pwd -s $jfrog_url  |  jq -r '.children[] |select(.folder==true) | .uri' | sed 's/\///g' | awk '/ORBIT/{print}' > ${WORKSPACE}/scripts/version.txt
