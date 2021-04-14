:Variables
SET Path=%Path%;E:\buildmgr\apache-maven-3.6.3\bin;C:\Program Files\Git\usr\bin
SET buildName=%branchName%
SET main=%WORKSPACE%

SET config=%main%\buildscripts
SET extnSourceLocation=%main%\orbitextn\orbit_extn
SET externalextnSourceLocation=%main%\orbitextn\external_extn\netsuite_adapter
SET orbitHelpLocation=%main%\orbithelp
SET reportingSourceLocation=%main%\orbitbootapp\orbit-app\orbit-web\
SET glsenseSourceLocation=%main%\orbitbootapp\orbit-app\orbit-excel-addons\GLSense
SET xlEdgeSourceLocation=%main%\orbitbootapp\orbit-app\orbit-excel-addons\XLEdge

SET sourceWARLocation=E:/Share/orbit_builds/%serverType%/%buildName%
rem SET sourceWARLocation=C:/Users/DELL/eclipse-workspace/OrbitReporting/target/%serverType%/%buildName%
SET orbExtnLibraryLocation=%sourceWARLocation%
SET tempLocation=%JENKINS_HOME%\orbittemp\%serverType%\%buildName%
SET extnTempLocation=%tempLocation%\extnlib
SET destinationTomcatLocation=%sourceWARLocation%/builds/

SET destinationDebugLocation=%sourceWARLocation%/debug/

SET tomcatConfig=%config%\orbit-configurations

SET senchasource67=E:\buildmgr\sencha-ext\6.7.0\ext-6.7.0.161
SET senchapackages67=E:\buildmgr\sencha-ext\6.7.0\ext-addons-6.7.0.161\packages

SET senchasource53=E:\buildmgr\sencha-ext\6.5.3\ext-6.5.3.57
SET senchapackages53=E:\buildmgr\sencha-ext\6.5.3\ext-addons-6.5.3.57\packages

SET senchasource72=E:\buildmgr\sencha-ext\7.2.0\ext-7.2.0
SET senchapackages72=E:\buildmgr\sencha-ext\7.2.0\ext-addons-7.2.0\packages

SET artifactoryUserName=admin
SET artifactoryPassword=56Gxu5-AF@
SET artifactoryHostName=jenkins.orbit8.com:8081