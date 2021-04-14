#!/bin/sh

# Orbit Home directory
export ORBIT_HOME=/orbhome/prd

# Memory settings
export CATALINA_OPTS="$CATALINA_OPTS -Xms1G"
export CATALINA_OPTS="$CATALINA_OPTS -Xmx12G"

# Orbit customized properties
export OVERRIDE_PROPERTIES_FILE=$ORBIT_HOME/conf/orbit.properties

# (optional: to override logging configuration)Below line to load logback config from ORBIT_HOME/conf
# export JAVA_OPTS="$JAVA_OPTS -Dlogging.config=file:$ORBIT_HOME/conf/logback-spring.xml"

# Below line to set jasypt password if any properties are encrypted in orbit.properties
#export JAVA_OPTS="$JAVA_OPTS -Djasypt.encryptor.password=<YOUR-SECRET-HERE>"

# Path settings
export JAVA_HOME=/u01/jdk1.8.0_231
export PATH=$JAVA_HOME/bin:$PATH

######################## DO NOT CHANGE BELOW PROPERTIES

# Order of properties files
export JAVA_OPTS="$JAVA_OPTS -Dspring.config.location=classpath:/,file:$OVERRIDE_PROPERTIES_FILE"

# Configure Orbit's Storage
export JAVA_OPTS="$JAVA_OPTS -Dorbit.reporting.home.path=$ORBIT_HOME"

# Configure Properties file into environment
export JAVA_OPTS="$JAVA_OPTS -Dorbit.properties.override.file=$OVERRIDE_PROPERTIES_FILE"

# Parser definitions
export JAVA_OPTS="$JAVA_OPTS -Djavax.xml.parsers.SAXParserFactory=com.sun.org.apache.xerces.internal.jaxp.SAXParserFactoryImpl -Djavax.xml.parsers.DocumentBuilderFactory=com.sun.org.apache.xerces.internal.jaxp.DocumentBuilderFactoryImpl -Djavax.xml.transform.TransformerFactory=com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl -Djavax.xml.xpath.XPathFactory:http://java.sun.com/jaxp/xpath/dom=com.sun.org.apache.xpath.internal.jaxp.XPathFactoryImpl"