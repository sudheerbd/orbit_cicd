#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

cd $config/poststeps

jar -cMf ORBIT_HOME.zip ORBIT_HOME

if [ -d "$destinationTomcatLocation/ORBIT_HOME.zip" ] 
then
    rm $destinationTomcatLocation/ORBIT_HOME.zip
fi
mv ORBIT_HOME.zip $destinationTomcatLocation