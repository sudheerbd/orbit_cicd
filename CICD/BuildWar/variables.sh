export buildName=${BRANCH_NAME}
export main=${WORKSPACE}
export servertype=${SERVER_TYPE}

export GIT_TRACE_PACKET=1
export GIT_TRACE=1
 
export config=$main/CICD/BuildWar
export extnSourceLocation=$main/orbitextn/orbit_extn
export externalextnSourceLocation=$main/orbitextn/external_extn/netsuite_adapter
export orbitHelpLocation=$main/orbithelp
export orbitbootappLocation=$main/orbitbootapp
export reportingSourceLocation=$main/orbitbootapp/orbit-app/orbit-web
export glsenseSourceLocation=$main/orbitbootapp/orbit-app/orbit-excel-addons/GLSense
export xlEdgeSourceLocation=$main/orbitbootapp/orbit-app/orbit-excel-addons/XLEdge

export sourceWARLocation=$main/$servertype/$buildName
export orbExtnLibraryLocation=$sourceWARLocation
export tempLocation=$main/orbittemp/$servertype/$buildName
export extnTempLocation=$tempLocation/extnlib
export destinationTomcatLocation=$sourceWARLocation/builds

export destinationDebugLocation=$sourceWARLocation/debug

export tomcatConfig=$config/orbit-configurations

export senchasource67=/tmp/sencha-ext/6.7.0/ext-6.7.0.161
export senchapackages67=/tmp/sencha-ext/6.7.0/ext-addons-6.7.0.161/packages

export senchasource53=/tmp/sencha-ext/6.5.3/ext-6.5.3.57
export senchapackages53=/tmp/sencha-ext/6.5.3/ext-addons-6.5.3.57/packages

export senchasource72=${JENKINS_HOME}/ext-7.2.0
export senchapackages72=${JENKINS_HOME}/ext-addons-7.2.0/packages

export artifactoryUserName=admin
export artifactoryPassword=56Gxu5-AF@
export artifactoryHostName=jenkins.orbit8.com:8081