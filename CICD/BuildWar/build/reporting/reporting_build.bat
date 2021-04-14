call .\buildscripts\variables.bat

cd %reportingSourceLocation%\..\
mvn clean install -Dmaven.test.skip=true -Dbuild.number=-%1
echo %1