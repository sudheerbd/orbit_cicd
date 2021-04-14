call .\buildscripts\variables.bat

call %config%\build\replace_env_variables.bat

copy /Y %config%\build\external_extn\orbextn_build.bat %externalextnSourceLocation%
copy /Y %config%\build\orbit_env.properties %externalextnSourceLocation%
%externalextnSourceLocation%\orbextn_build.bat ${BUILD_NUMBER}