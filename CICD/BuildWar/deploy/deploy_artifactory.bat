call .\buildscripts\variables.bat

curl -s -f -u %artifactoryUserName%:%artifactoryPassword% -T "%destinationTomcatLocation%\reporting.war" "http://%artifactoryHostName%/artifactory/orbit-releases/%buildName%/reporting.war"
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

curl -s -f -u %artifactoryUserName%:%artifactoryPassword% -T "%destinationTomcatLocation%\ORBIT_HOME.zip" "http://%artifactoryHostName%/artifactory/orbit-releases/%buildName%/ORBIT_HOME.zip"
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%