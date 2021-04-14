call .\buildscripts\variables.bat

call RD "%tempLocation%\deploy3\" /s /q
mkdir "%tempLocation%\deploy3\"
cd %tempLocation%\deploy3\

if "%isDevelopment%"=="true" (
call copy "%destinationDebugLocation%\reporting.war" "%tempLocation%\deploy3\reporting.war"
) else if "%isDevelopment%"=="false" (
call copy "%destinationTomcatLocation%\reporting.war" "%tempLocation%\deploy3\reporting.war"
)

mkdir "%tempLocation%\deploy3\WEB-INF\classes\"
call copy "%tomcatConfig%\%tomcatHostname3%\%tomcatPort3%\application-dev.properties" "%tempLocation%\deploy3\WEB-INF\classes\"
call copy "%tomcatConfig%\%tomcatHostname3%\%tomcatPort3%\application-qa.properties" "%tempLocation%\deploy3\WEB-INF\classes\"
call copy "%tomcatConfig%\%tomcatHostname3%\%tomcatPort3%\application.properties" "%tempLocation%\deploy3\WEB-INF\classes\"
::zip -d "%tempLocation%\deploy3\reporting.war" WEB-INF/classes/application-dev.properties
::zip -d "%tempLocation%\deploy3\reporting.war" WEB-INF/classes/application-qa.properties
::zip -d "%tempLocation%\deploy3\reporting.war" WEB-INF/classes/application.properties
zip -ur "%tempLocation%\deploy3\reporting.war"  WEB-INF
curl -s -f -u %tomcatUsername3%:%tomcatPassword3% -T "%tempLocation%\deploy3\reporting.war" "http://%tomcatHostname3%:%tomcatPort3%/manager/text/deploy?path=/reporting&update=true"
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%
cd %tempLocation%
call RD "%tempLocation%\deploy3\" /s /q