call .\buildscripts\variables.bat

call %config%\build\replace_env_variables.bat

copy /Y %config%\build\extn\orbextn_build.bat %extnSourceLocation%
copy /Y %config%\build\orbit_env.properties %extnSourceLocation%
%extnSourceLocation%\orbextn_build.bat ${BUILD_NUMBER}