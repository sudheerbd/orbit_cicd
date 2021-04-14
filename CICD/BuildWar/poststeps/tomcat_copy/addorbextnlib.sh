#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

isDevelopment=${IS_DEVELOPMENT}

# create directories if doen't exist.
if [ ! -d "$sourceWARLocation" ]; then
    mkdir -p $sourceWARLocation
    chmod -R 700 $sourceWARLocation
fi 

if [ ! -d "$tempLocation/reporting" ]; then 
    mkdir -p $tempLocation/reporting
    chmod -R 700 $tempLocation/reporting
fi 

if [ ! -d "$tempLocation/deliveries" ]; then 
    mkdir -p $tempLocation/deliveries
    chmod -R 700 $tempLocation/deliveries
fi 

if [ ! -d "$extnTempLocation" ]; then 
    mkdir -p $extnTempLocation
    chmod -R 700 $extnTempLocation 
fi

if [ ! -d "$destinationTomcatLocation" ]; then 
    mkdir -p $destinationTomcatLocation
    chmod -R 700 $destinationTomcatLocation
fi

if [ ! -d "$destinationDebugLocation" ]; then 
    mkdir -p $destinationDebugLocation
    chmod -R 700 $destinationDebugLocation
fi 

# Cleanup all directories
rm -rf $tempLocation/reporting/*

cd $tempLocation/reporting

rm -rf auth
rm -rf META-INF
rm -rf orbitui
rm -rf resources
rm -rf WEB-INF

echo "Copying the latest ORBIT extension library"
if [ -d "$orbExtnLibraryLocation" ];
then
    cd $orbExtnLibraryLocation
    NewestFile=$(find . -type f -name "orbextn*.jar" -printf '%T@ %p\n' | sort -n --field-separator='|' | tail -1 | cut -f2- -d" ")
    cp -r $NewestFile $extnTempLocation
fi

echo "Renaming the new jar file to orbextn.jar file"
cd $extnTempLocation
mv orbextn*.* orbextn.jar

echo "Copying the latest ORBIT external extension library"
if [ -d "$orbExtnLibraryLocation" ];
then
    cd $orbExtnLibraryLocation
    NewestFile=$(find . -type f -name "external_extn*.jar" -printf '%T@ %p\n' | sort -n --field-separator='|' | tail -1 | cut -f2- -d" ")
    cp -r $NewestFile $extnTempLocation
fi

echo "Renaming the new jar file to external_extn.jar file"
cd $extnTempLocation
mv external_extn*.* external_extn.jar

echo "Copy the latest war file from deployment directory"

if [ -d "$sourceWARLocation" ];
then
    cd $sourceWARLocation
    NewestFile=$(find . -type f -name "reporting*.war" -printf '%T@ %p\n' | sort -n --field-separator='|' | tail -1 | cut -f2- -d" ")
    cp -r $NewestFile $tempLocation/reporting
fi

echo "Renaming the new war file to reporting.war file"
cd $tempLocation/reporting
mv reporting*.* reporting.war

echo "Extract reporting.war file"
jar xf reporting.war

cd $orbitbootappLocation
export reporting_head=$(git rev-parse HEAD)
export orbit_build_version_file=$tempLocation/reporting/WEB-INF/views/orb-version.jsp

if [ -f "$orbit_build_version_file" ] 
then
    sed -i "s/VERSIONVALUE/$reporting_head/g" $orbit_build_version_file
fi

echo "Delete the reporting.war file"
rm -rf $tempLocation/reporting/reporting.war

rm -rf $tempLocation/reporting/WEB-INF/lib/orbext*.jar

mv $extnTempLocation/orbextn.jar $tempLocation/reporting/WEB-INF/lib

mv $extnTempLocation/external_extn.jar $tempLocation/reporting/WEB-INF/lib

rm -rf $tempLocation/reporting/WEB-INF/lib/slf4j-log4j12-1.6.6.jar

rm -rf $tempLocation/reporting/resources/ORBIT-Help/*

cp -r $orbitHelpLocation/\!SSL\!/WebHelp $tempLocation/reporting/resources/ORBIT-Help >nul 2>&1

cd $tempLocation/reporting
jar -cvfM reporting.war * >nul 2>&1
mv reporting.war $tempLocation/deliveries

cd $tempLocation/deliveries

if [ $isDevelopment == "true" ]
then
    mv reporting.war $destinationDebugLocation
else
    mv reporting.war $destinationTomcatLocation
fi

echo "clean the reporting folder"
rm -rf $tempLocation/reporting

cd $tempLocation
