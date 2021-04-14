#!/bin/bash
. ./buildscripts/variables.sh
. $main/scripts/env_variables.sh

curl -s -f -u $artifactoryUserName:$artifactoryPassword -T $destinationTomcatLocation/reporting.war http://$artifactoryHostName/artifactory/orbit-releases/$buildName/reporting.war
if [ $? -ne 0 ]; then exit; fi

curl -s -f -u $artifactoryUserName:$artifactoryPassword -T $destinationTomcatLocation/ORBIT_HOME.zip http://$artifactoryHostName/artifactory/orbit-releases/$buildName/ORBIT_HOME.zip
if [ $? -ne 0 ]; then exit; fi