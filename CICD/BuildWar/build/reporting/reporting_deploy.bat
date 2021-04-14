call .\buildscripts\variables.bat

if "%isDevelopment%"=="true" (
call %config%\build\replace_dev_env_variables.bat
) else if "%isDevelopment%"=="false" (
call %config%\build\replace_env_variables.bat
)

copy /Y %config%\build\reporting\reporting_build.bat %reportingSourceLocation%
copy /Y %config%\build\orbit_env.properties %reportingSourceLocation%

if "%extjsVersion%"=="Extjs_6.5.3" (
	SET senchasource=%senchasource53%
	SET senchapackages=%senchapackages53%
) else if "%extjsVersion%"=="Extjs_6.7" (
	SET senchasource=%senchasource67%
	SET senchapackages=%senchapackages67%
) else if "%extjsVersion%"=="Extjs_7.2" (
	SET senchasource=%senchasource72%
	SET senchapackages=%senchapackages72%
)


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
cd %main%
%reportingSourceLocation%\reporting_build.bat ${BUILD_NUMBER}