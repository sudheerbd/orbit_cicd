#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

cp $config/build/extn/orbextn_build.sh $extnSourceLocation
cp $config/build/orbit_env.properties $extnSourceLocation

$extnSourceLocation/orbextn_build.sh