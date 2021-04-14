REM Orbit Home directory
set ORBIT_HOME=C:/orbhome/prd

REM Memory settings
set "CATALINA_OPTS=%CATALINA_OPTS% -Xms1G"
set "CATALINA_OPTS=%CATALINA_OPTS% -Xmx12G"

REM Orbit customized properties
set "OVERRIDE_PROPERTIES_FILE=%ORBIT_HOME%/conf/orbit.properties"

REM (optional: to override logging configuration)Below line to load logback config from ORBIT_HOME/conf
REM set "JAVA_OPTS=%JAVA_OPTS% -Dlogging.config=file:%ORBIT_HOME%/conf/logback-spring.xml"

REM Below line to set jasypt password if any properties are encrypted in orbit.properties
REM set "JAVA_OPTS=%JAVA_OPTS% -Djasypt.encryptor.password=<YOUR-SECRET-HERE>"

REM Path settings
set "JAVA_HOME=C:/jdk1.8.0_231"
set "PATH=%JAVA_HOME%/bin;%PATH%"

REM ############## DO NOT CHANGE BELOW PROPERTIES

REM Order of properties files
set "JAVA_OPTS=%JAVA_OPTS% -Dspring.config.location=classpath:/,file:%OVERRIDE_PROPERTIES_FILE%"

REM Configure Orbit's Storage
set "JAVA_OPTS=%JAVA_OPTS% -Dorbit.reporting.home.path=%ORBIT_HOME%"

REM Configure Properties file into environment
set "JAVA_OPTS=%JAVA_OPTS% -Dorbit.properties.override.file=%OVERRIDE_PROPERTIES_FILE%"

REM Parser definitions
set "JAVA_OPTS=%JAVA_OPTS% -Djavax.xml.parsers.SAXParserFactory=com.sun.org.apache.xerces.internal.jaxp.SAXParserFactoryImpl -Djavax.xml.parsers.DocumentBuilderFactory=com.sun.org.apache.xerces.internal.jaxp.DocumentBuilderFactoryImpl -Djavax.xml.transform.TransformerFactory=com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl -Djavax.xml.xpath.XPathFactory:http://java.sun.com/jaxp/xpath/dom=com.sun.org.apache.xpath.internal.jaxp.XPathFactoryImpl"