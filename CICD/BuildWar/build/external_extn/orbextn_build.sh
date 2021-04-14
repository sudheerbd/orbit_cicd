#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

cd $externalextnSourceLocation
mvn clean install -Dbuild.number=${BUILD_NUMBER}
echo ${BUILD_NUMBER}