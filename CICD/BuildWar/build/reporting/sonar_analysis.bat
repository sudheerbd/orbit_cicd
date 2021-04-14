call .\buildscripts\variables.bat

call %config%\build\replace_env_variables.bat

copy /Y %config%\build\orbit_env.properties %reportingSourceLocation%

::if not exist %reportingSourceLocation%\src\main\webapp\orbitui\ext\packages (
	cd %reportingSourceLocation%\src\main\webapp\orbitui
	call sencha app upgrade %senchasource%
	call xcopy %senchapackages% .\ext\packages /E /i /Y >nul 2>&1
	call RD .\ext\packages\d3\ /s /q
	cd %reportingSourceLocation%\src\main\webapp\orbitui\ext\classic
	call git ls-files -d | xargs git checkout 
	cd ..\..
	call xcopy %senchapackages%\d3 .\packages\d3 /E /i /Y >nul 2>&1
	call sencha app clean
::)
cd %reportingSourceLocation%\..\
call mvn clean verify sonar:sonar -Dmaven.test.skip=true