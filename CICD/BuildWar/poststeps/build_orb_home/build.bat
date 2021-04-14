call .\buildscripts\variables.bat

cd %config%\poststeps

call jar -cMf ORBIT_HOME.zip ORBIT_HOME
call move /Y ORBIT_HOME.zip "%destinationTomcatLocation%"