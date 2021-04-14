call .\buildscripts\variables.bat
goto :start

:expand
echo %~1>> %config%\build\orbit_env.properties
goto:eof

:start
echo. > %config%\build\orbit_env.properties
for /f "delims=" %%i in (%config%\build\orbit_env_dev.txt) do call:expand "%%i"