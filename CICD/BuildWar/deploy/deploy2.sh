#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

isDevelopment=${IS_DEVELOPMENT}
tomcatHostname1=${TOMCAT_HOSTNAME2}
tomcatPort1=${TOMCAT_PORT2}
tomcatUsername1=${TOMCAT_USERNAME2}
tomcatPassword1=${TOMCAT_PASSWORD2}

if [ -d "$tempLocation/deploy2" ] 
then
    rm $tempLocation/deploy2
fi

mkdir -p $tempLocation/deploy2
cd $tempLocation/deploy2

if [ $isDevelopment == "true" ];
then
    cp $destinationDebugLocation/reporting.war $tempLocation/deploy2/reporting.war
else
    cp $destinationTomcatLocation/reporting.war $tempLocation/deploy2/reporting.war
fi

mkdir -p $tempLocation/deploy2/WEB-INF/classes
cp $tomcatConfig/$tomcatHostname2/$tomcatPort2/application-dev.properties $tempLocation/deploy2/WEB-INF/classes
cp $tomcatConfig/$tomcatHostname2/$tomcatPort2/application-qa.properties $tempLocation/deploy2/WEB-INF/classes
cp $tomcatConfig/$tomcatHostname2/$tomcatPort2/application.properties $tempLocation/deploy2/WEB-INF/classes

# ON Master branch
# if [ -d $tomcatConfig/$tomcatHostname2/$tomcatPort2/licenses ]; 
# then
# 	mkdir $tempLocation/deploy2/licenses/
# 	cp -r $tomcatConfig/$tomcatHostname2/$tomcatPort2/licenses $tempLocation/deploy2/licenses/
# 	zip -ur $tempLocation/deploy2/reporting.war  licenses
# fi

# zip -d $tempLocation/deploy2/reporting.war WEB-INF/classes/application-dev.properties
# zip -d $tempLocation/deploy2/reporting.war WEB-INF/classes/application-qa.properties
# zip -d $tempLocation/deploy2/reporting.war WEB-INF/classes/application.properties

zip -ur $tempLocation/deploy2/reporting.war  WEB-INF
curl -s -f -u $tomcatUsername2:$tomcatPassword2 -T $tempLocation/deploy2/reporting.war "http://$tomcatHostname2:$tomcatPort2/manager/text/deploy?path=/reporting&update=true"
if [ $? -ne 0 ];
then
   exit
fi
rm $tempLocation/deploy2