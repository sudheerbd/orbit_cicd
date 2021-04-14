#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

isDevelopment=${IS_DEVELOPMENT}
tomcatHostname1=${TOMCAT_HOSTNAME3}
tomcatPort1=${TOMCAT_PORT3}
tomcatUsername1=${TOMCAT_USERNAME3}
tomcatPassword1=${TOMCAT_PASSWORD3}

if [ -d "$tempLocation/deploy3" ] 
then
    rm $tempLocation/deploy3
fi

mkdir -p $tempLocation/deploy3
cd $tempLocation/deploy3

if [ $isDevelopment == "true" ];
then
    cp $destinationDebugLocation/reporting.war $tempLocation/deploy3/reporting.war
else
    cp $destinationTomcatLocation/reporting.war $tempLocation/deploy3/reporting.war
fi

mkdir -p $tempLocation/deploy3/WEB-INF/classes
cp $tomcatConfig/$tomcatHostname3/$tomcatPort3/application-dev.properties $tempLocation/deploy3/WEB-INF/classes
cp $tomcatConfig/$tomcatHostname3/$tomcatPort3/application-qa.properties $tempLocation/deploy3/WEB-INF/classes
cp $tomcatConfig/$tomcatHostname3/$tomcatPort3/application.properties $tempLocation/deploy3/WEB-INF/classes

# ON Master branch
# if [ -d $tomcatConfig/$tomcatHostname3/$tomcatPort3/licenses ]; 
# then
# 	mkdir $tempLocation/deploy3/licenses/
# 	cp -r $tomcatConfig/$tomcatHostname3/$tomcatPort3/licenses $tempLocation/deploy3/licenses/
# 	zip -ur $tempLocation/deploy3/reporting.war  licenses
# fi

# zip -d $tempLocation/deploy3/reporting.war WEB-INF/classes/application-dev.properties
# zip -d $tempLocation/deploy3/reporting.war WEB-INF/classes/application-qa.properties
# zip -d $tempLocation/deploy3/reporting.war WEB-INF/classes/application.properties

zip -ur $tempLocation/deploy3/reporting.war  WEB-INF
curl -s -f -u $tomcatUsername3:$tomcatPassword3 -T $tempLocation/deploy3/reporting.war "http://$tomcatHostname3:$tomcatPort3/manager/text/deploy?path=/reporting&update=true"
if [ $? -ne 0 ];
then
   exit
fi
rm $tempLocation/deploy3