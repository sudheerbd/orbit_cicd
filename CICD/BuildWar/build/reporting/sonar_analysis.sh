#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

extjsVersion=${EXTJS_VERSION}

if [ "$extjsVersion" = "Extjs_6.5.3" ]
then
	export senchasource=$senchasource53
	export senchapackages=$senchapackages53
elif [ "$extjsVersion" = "Extjs_6.7" ]
then
	export senchasource=$senchasource53
	export senchapackages=$senchapackages53
elif [ "$extjsVersion" = "Extjs_7.2" ]
then
	export senchasource=$senchasource72
	export senchapackages=$senchapackages72
else
	echo "sencha source path not set properly"
fi

cp $config/build/orbit_env.properties $reportingSourceLocation

cd $reportingSourceLocation/src/main/webapp/orbitui
sencha app upgrade $senchasource
cp -r $senchapackages ./ext/packages >nul 2>&1
rm -rf ./ext/packages/d3/
cd $reportingSourceLocation/src/main/webapp/orbitui/ext/classic
git ls-files -d | xargs git checkout 
cd ../..
cp -r $senchapackages/d3 ./packages/d3 >nul 2>&1
sencha app clean

cd $reportingSourceLocation 
mvn clean verify sonar:sonar -Dmaven.test.skip=true