#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

cd $reportingSourceLocation
cd ..
mvn clean install -Dmaven.test.skip=true -Dbuild.number=$BUILD_NUMBER
echo $BUILD_NUMBER