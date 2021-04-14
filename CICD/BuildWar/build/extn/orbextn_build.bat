call .\buildscripts\variables.bat

cd %extnSourceLocation%
mvn clean install -Dbuild.number=-%1
echo %1