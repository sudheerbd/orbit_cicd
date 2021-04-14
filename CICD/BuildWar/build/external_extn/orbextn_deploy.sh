#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

cp $config/build/external_extn/orbextn_build.sh $externalextnSourceLocation
cp $config/build/orbit_env.properties $externalextnSourceLocation

$externalextnSourceLocation/orbextn_build.sh
