call .\buildscripts\variables.bat

cd %externalextnSourceLocation%
mvn clean install -Dbuild.number=-%1
echo %1