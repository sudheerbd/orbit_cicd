#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

orbit_env_file="$config/build/orbit_env.txt"
while IFS= read -r line
do
  eval echo $line >> $config/build/orbit_env.properties
done < "$orbit_env_file"