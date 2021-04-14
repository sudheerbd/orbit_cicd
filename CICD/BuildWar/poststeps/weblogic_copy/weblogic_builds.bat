call .\buildscripts\variables.bat

REM create directories if doen't exist.
if not exist "%sourceWARLocation%" mkdir "%sourceWARLocation%"
if not exist "%tempLocation%\reporting" mkdir "%tempLocation%\reporting"
if not exist "%tempLocation%\shared_library\WEB-INF\lib" mkdir "%tempLocation%\shared_library\WEB-INF\lib"
if not exist "%tempLocation%\deliveries" mkdir "%tempLocation%\deliveries"
if not exist "%extnTempLocation%" mkdir "%extnTempLocation%"
if not exist "%destinationTomcatLocation%" mkdir "%destinationTomcatLocation%"
if not exist "%destinationDebugLocation%" mkdir "%destinationDebugLocation%"

REM Cleanup all directories
call DEL /F /Q /A "%tempLocation%\reporting\*.*"
call DEL /F /Q /A "%tempLocation%\shared_library\manifest.txt"
call DEL /F /Q /A "%tempLocation%\shared_library\WEB-INF\lib\*.*"

cd "%tempLocation%\reporting"

call RD auth /s /q
call RD META-INF /s /q
call RD orbitui /s /q
call RD resources /s /q
call RD WEB-INF /s /q

echo "Copying the latest ORBIT extension library"
FOR /F "delims=|" %%I IN ('DIR "%sourceWARLocation%\orbext*.jar" /B /O:D') DO SET NewestFile=%%I
call copy /Y "%sourceWARLocation%\%NewestFile%" "%extnTempLocation%"

echo "Renaming the new war file to reporting.war file"
cd "%extnTempLocation%"
call RENAME *-* orbextn.jar

echo "Copyin the latest ORBIT external extension library"
FOR /F "delims=|" %%I IN ('DIR "%sourceWARLocation%\external_extn*.jar" /B /O:D') DO SET NewestFile=%%I
call copy /Y "%orbExtnLibraryLocation%\%NewestFile%" "%extnTempLocation%"

echo "Renaming the new war file to reporting.war file"
cd "%extnTempLocation%"
call RENAME *-* external_extn.jar

echo Copy the latest war file from deployment directory
FOR /F "delims=|" %%I IN ('DIR "%sourceWARLocation%\reporting-*.war" /B /O:D') DO SET NewestFile=%%I
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

call DEL /F /Q /A "%tempLocation%\reporting\resources\ORBIT-Help\*"

call xcopy "%orbitHelpLocation%\!SSL!\WebHelp" "%tempLocation%\reporting\resources\ORBIT-Help\" /E /i /Y>nul 2>&1

echo "Moving all the jar files into shred library"
call move /Y "%tempLocation%\reporting\WEB-INF\lib\*.*" "%tempLocation%\shared_library\WEB-INF\lib" >nul 2>&1

call DEL /F /Q /A "%tempLocation%\reporting\WEB-INF\lib\orbext*.jar"
::cd "%extnTempLocation%"
::call jar xf orbextn.jar
::call DEL /F /Q /A "%extnTempLocation%\orbextn.jar"
::call java -cp %config% GetSCMRevision %main%\orbitreporting %extnTempLocation%\META-INF\MANIFEST.MF
::call jar -cvfM orbextn.jar * >nul 2>&1
call move /Y "%extnTempLocation%\orbextn.jar" "%tempLocation%\reporting\WEB-INF\lib"

call move /Y "%extnTempLocation%\external_extn.jar" "%tempLocation%\reporting\WEB-INF\lib"

rem echo "Copying weblogic.xml file"
rem call copy /Y "%config%\poststeps\weblogic_copy\weblogic.xml" "%tempLocation%\reporting\WEB-INF"

echo "Copying web.xml file"
call copy /Y "%config%\poststeps\weblogic_copy\weblogic_web.xml" "%tempLocation%\shared_library\WEB-INF\web.xml"

echo "rebuild the entire reporting.war again with orbextn.jar"
cd "%tempLocation%\reporting"
call jar -cvfM reporting.war * >nul 2>&1
call move /Y reporting.war "%tempLocation%\deliveries"

echo "Copying manifest.txt file"
call copy /Y "%config%\poststeps\weblogic_copy\manifest.txt" "%tempLocation%\shared_library"

call DEL /F /Q /A "%tempLocation%\shared_library\WEB-INF\lib\eclipselink*.jar"
call DEL /F /Q /A "%tempLocation%\shared_library\WEB-INF\lib\slf4j-log4j12-1.6.6.jar"
call DEL /F /Q /A "%tempLocation%\shared_library\WEB-INF\lib\orbextn.jar"
call DEL /F /Q /A "%tempLocation%\shared_library\WEB-INF\lib\reporting-*.jar"
call DEL /F /Q /A "%tempLocation%\shared_library\WEB-INF\lib\xmlparserv2.jar"
call zip -d -q "%tempLocation%\shared_library\WEB-INF\lib\jboss-modules-1.6.1.Final.jar" "META-INF/versions/*"
call zip -d -q "%tempLocation%\shared_library\WEB-INF\lib\jboss-marshalling-2.0.2.Final.jar" "META-INF/versions/*"
call copy /Y "%config%\poststeps\weblogic_copy\lib\*.jar" "%tempLocation%\shared_library\WEB-INF\lib\"

cd "%tempLocation%\shared_library"
call jar -cvfm OrbitJars.war manifest.txt . >nul 2>&1
call move /Y OrbitJars.war "%tempLocation%\deliveries"

cd "%tempLocation%\deliveries"

if "%isDevelopment%"=="true" (
call move /Y OrbitJars.war "%destinationDebugLocation%"
call move /Y reporting.war "%destinationDebugLocation%"
) else if "%isDevelopment%"=="false" (
call move /Y OrbitJars.war "%destinationTomcatLocation%"
call move /Y reporting.war "%destinationTomcatLocation%"
)

call RD "%tempLocation%\reporting" /s /q
call RD "%tempLocation%\extnlib" /s /q
call RD "%tempLocation%\shared_library" /s /q
call RD "%tempLocation%\deliveries" /s /q

cd %tempLocation%
