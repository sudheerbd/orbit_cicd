#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

isDevelopment=${IS_DEVELOPMENT}
tomcatHostname1=${TOMCAT_HOSTNAME1}
tomcatPort1=${TOMCAT_PORT1}
tomcatUsername1=${TOMCAT_USERNAME1}
tomcatPassword1=${TOMCAT_PASSWORD1}

if [ -d "$tempLocation/deploy1" ] 
then
    rm $tempLocation/deploy1
fi

mkdir -p $tempLocation/deploy1
cd $tempLocation/deploy1

if [ $isDevelopment == "true" ];
then
    cp $destinationDebugLocation/reporting.war $tempLocation/deploy1/reporting.war
else
    cp $destinationTomcatLocation/reporting.war $tempLocation/deploy1/reporting.war
fi

mkdir -p $tempLocation/deploy1/WEB-INF/classes
cp $tomcatConfig/$tomcatHostname1/$tomcatPort1/application-dev.properties $tempLocation/deploy1/WEB-INF/classes
cp $tomcatConfig/$tomcatHostname1/$tomcatPort1/application-qa.properties $tempLocation/deploy1/WEB-INF/classes
cp $tomcatConfig/$tomcatHostname1/$tomcatPort1/application.properties $tempLocation/deploy1/WEB-INF/classes

# ON Master branch
# if [ -d $tomcatConfig/$tomcatHostname1/$tomcatPort1/licenses ]; 
# then
# 	mkdir $tempLocation/deploy1/licenses/
# 	cp -r $tomcatConfig/$tomcatHostname1/$tomcatPort1/licenses $tempLocation/deploy1/licenses/
# 	zip -ur $tempLocation/deploy1/reporting.war  licenses
# fi

# zip -d $tempLocation/deploy1/reporting.war WEB-INF/classes/application-dev.properties
# zip -d $tempLocation/deploy1/reporting.war WEB-INF/classes/application-qa.properties
# zip -d $tempLocation/deploy1/reporting.war WEB-INF/classes/application.properties

zip -ur $tempLocation/deploy1/reporting.war  WEB-INF
curl -s -f -u $tomcatUsername1:$tomcatPassword1 -T $tempLocation/deploy1/reporting.war "http://$tomcatHostname1:$tomcatPort1/manager/text/deploy?path=/reporting&update=true"
if [ $? -ne 0 ];
then
   exit
fi
rm $tempLocation/deploy1