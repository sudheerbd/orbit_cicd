call .\buildscripts\variables.bat

call RD "%tempLocation%\deploy1\" /s /q
mkdir "%tempLocation%\deploy1\"
cd %tempLocation%\deploy1\

if "%isDevelopment%"=="true" (
call copy "%destinationDebugLocation%\reporting.war" "%tempLocation%\deploy1\reporting.war"
) else if "%isDevelopment%"=="false" (
call copy "%destinationTomcatLocation%\reporting.war" "%tempLocation%\deploy1\reporting.war"
)


mkdir "%tempLocation%\deploy1\WEB-INF\classes\"
call copy "%tomcatConfig%\%tomcatHostname1%\%tomcatPort1%\application-dev.properties" "%tempLocation%\deploy1\WEB-INF\classes\"
call copy "%tomcatConfig%\%tomcatHostname1%\%tomcatPort1%\application-qa.properties" "%tempLocation%\deploy1\WEB-INF\classes\"
call copy "%tomcatConfig%\%tomcatHostname1%\%tomcatPort1%\application.properties" "%tempLocation%\deploy1\WEB-INF\classes\"
::zip -d "%tempLocation%\deploy1\reporting.war" WEB-INF/classes/application-dev.properties
::zip -d "%tempLocation%\deploy1\reporting.war" WEB-INF/classes/application-qa.properties
::zip -d "%tempLocation%\deploy1\reporting.war" WEB-INF/classes/application.properties
zip -ur "%tempLocation%\deploy1\reporting.war"  WEB-INF
curl -s -f -u %tomcatUsername1%:%tomcatPassword1% -T "%tempLocation%\deploy1\reporting.war" "http://%tomcatHostname1%:%tomcatPort1%/manager/text/deploy?path=/reporting&update=true"
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%
cd %tempLocation%
call RD "%tempLocation%\deploy1\" /s /q