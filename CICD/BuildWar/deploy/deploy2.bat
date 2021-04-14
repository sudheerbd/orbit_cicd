call .\buildscripts\variables.bat

call RD "%tempLocation%\deploy2\" /s /q
mkdir "%tempLocation%\deploy2\"
cd %tempLocation%\deploy2\

if "%isDevelopment%"=="true" (
call copy "%destinationDebugLocation%\reporting.war" "%tempLocation%\deploy2\reporting.war"
) else if "%isDevelopment%"=="false" (
call copy "%destinationTomcatLocation%\reporting.war" "%tempLocation%\deploy2\reporting.war"
)

mkdir "%tempLocation%\deploy2\WEB-INF\classes\"
call copy "%tomcatConfig%\%tomcatHostname2%\%tomcatPort2%\application-dev.properties" "%tempLocation%\deploy2\WEB-INF\classes\"
call copy "%tomcatConfig%\%tomcatHostname2%\%tomcatPort2%\application-qa.properties" "%tempLocation%\deploy2\WEB-INF\classes\"
call copy "%tomcatConfig%\%tomcatHostname2%\%tomcatPort2%\application.properties" "%tempLocation%\deploy2\WEB-INF\classes\"

::zip -d "%tempLocation%\deploy2\reporting.war" WEB-INF/classes/application-dev.properties
::zip -d "%tempLocation%\deploy2\reporting.war" WEB-INF/classes/application-qa.properties
::zip -d "%tempLocation%\deploy2\reporting.war" WEB-INF/classes/application.properties
zip -ur "%tempLocation%\deploy2\reporting.war"  WEB-INF
curl -s -f -u %tomcatUsername2%:%tomcatPassword2% -T "%tempLocation%\deploy2\reporting.war" "http://%tomcatHostname2%:%tomcatPort2%/manager/text/deploy?path=/reporting&update=true"
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%
cd %tempLocation%
call RD "%tempLocation%\deploy2\" /s /q