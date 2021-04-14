#!/bin/bash
. ./CICD/BuildWar/variables.sh
. ./CICD/BuildWar/build/replace_env_variables.sh
. $main/scripts/env_variables.sh

extjsVersion=${EXTJS_VERSION}

cp $config/build/reporting/reporting_build.sh $reportingSourceLocation
cp $config/build/orbit_env.properties $reportingSourceLocation

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
	
if [ "$servertype" = "weblogic" ]
then
	cp $config/build/reporting/weblogic.xml $reportingSourceLocation/src/main/webapp/WEB-INF
	cp $config/build/reporting/manifest.txt $reportingSourceLocation/src/main/webapp/WEB-INF
fi

if [ ! -d $reportingSourceLocation/src/main/webapp/orbitui/ext/packages ]; then
	cd $reportingSourceLocation/src/main/webapp/orbitui
	sencha app upgrade $senchasource
	cp -r $senchapackages/* ./ext/packages
	rm -rf ./ext/packages/d3
	cd $reportingSourceLocation/src/main/webapp/orbitui/ext/classic
	git ls-files -d | xargs git checkout
	cd ../.. 
	cp -r $senchapackages/d3 ./packages/d3 
	sencha app clean
fi

cd $main
$reportingSourceLocation/reporting_build.sh