call .\buildscripts\variables.bat

REM create directories if doen't exist.
if not exist "%sourceWARLocation%" mkdir "%sourceWARLocation%"
if not exist "%tempLocation%\reporting" mkdir "%tempLocation%\reporting"
if not exist "%tempLocation%\deliveries" mkdir "%tempLocation%\deliveries"
if not exist "%extnTempLocation%" mkdir "%extnTempLocation%"
if not exist "%destinationTomcatLocation%" mkdir "%destinationTomcatLocation%"
if not exist "%destinationDebugLocation%" mkdir "%destinationDebugLocation%"

REM Cleanup all directories
call DEL "%tempLocation%\reporting\*.*" /f /s /q

cd "%tempLocation%\reporting"

call RD auth /s /q
call RD META-INF /s /q
call RD orbitui /s /q
call RD resources /s /q
call RD WEB-INF /s /q

echo "Copyin the latest ORBIT extension library"
FOR /F "delims=|" %%I IN ('DIR "%orbExtnLibraryLocation%\orbextn*.jar" /B /O:D') DO SET NewestFile=%%I
call copy /Y "%orbExtnLibraryLocation%\%NewestFile%" "%extnTempLocation%"

echo "Renaming the new jar file to orbextn.jar file"
cd "%extnTempLocation%"
call RENAME *-* orbextn.jar


echo "Copyin the latest ORBIT external extension library"
FOR /F "delims=|" %%I IN ('DIR "%orbExtnLibraryLocation%\external_extn*.jar" /B /O:D') DO SET NewestFile=%%I
call copy /Y "%orbExtnLibraryLocation%\%NewestFile%" "%extnTempLocation%"

echo "Renaming the new war file to reporting.war file"
cd "%extnTempLocation%"
call RENAME *-* external_extn.jar

echo Copy the latest war file from deployment directory
FOR /F "delims=|" %%I IN ('DIR "%sourceWARLocation%\reporting*.war" /B /O:D') DO SET NewestFile=%%I
call copy /Y "%sourceWARLocation%\%NewestFile%" "%tempLocation%\reporting"

echo "Renaming the new war file to reporting.war file"
cd "%tempLocation%\reporting"
call RENAME *-* reporting.war

echo "Extract reporting.war file"
call jar xf reporting.war

set /p reporting_head=<"%sourceWARLocation%\reportingheadversion.txt"
set "orbit_build_version_file=%tempLocation%\reporting\WEB-INF\views\orb-version.jsp"
set "orbit_build_version_tmp=%tempLocation%\reporting\WEB-INF\views\orb-version.txt"
SETLOCAL ENABLEDELAYEDEXPANSION
for /f "delims=" %%a in (%orbit_build_version_file%) do (
    SET s=%%a
    SET s=!s:VERSIONVALUE=%reporting_head%!
    echo !s!>>%orbit_build_version_tmp%
)
ENDLOCAL
call DEL /F /Q /A "%orbit_build_version_file%"
call RENAME "%orbit_build_version_tmp%" orb-version.jsp

echo "Delete the reporting.war file"
call DEL /F /Q /A "%tempLocation%\reporting\reporting.war"

REM cd "%tempLocation%\reporting\WEB-INF\lib"
call DEL /F /Q /A "%tempLocation%\reporting\WEB-INF\lib\orbext*.jar"
call move /Y "%extnTempLocation%\orbextn.jar" "%tempLocation%\reporting\WEB-INF\lib"

call move /Y "%extnTempLocation%\external_extn.jar" "%tempLocation%\reporting\WEB-INF\lib"

call DEL /F /Q /A "%tempLocation%\reporting\WEB-INF\lib\slf4j-log4j12-1.6.6.jar"

call DEL /F /Q /A "%tempLocation%\reporting\resources\ORBIT-Help\*"

call xcopy "%orbitHelpLocation%\!SSL!\WebHelp" "%tempLocation%\reporting\resources\ORBIT-Help\" /E /i /Y>nul 2>&1

cd "%tempLocation%\reporting"
call jar -cvfM reporting.war * >nul 2>&1
call move /Y reporting.war "%tempLocation%\deliveries"

cd "%tempLocation%\deliveries"

if "%isDevelopment%"=="true" (
call move /Y reporting.war "%destinationDebugLocation%"
) else if "%isDevelopment%"=="false" (
call move /Y reporting.war "%destinationTomcatLocation%"
)

echo "clean the reporting folder"
call RD "%tempLocation%\reporting" /s /q

cd %tempLocation%
