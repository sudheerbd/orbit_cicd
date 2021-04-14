#!/bin/sh

# Orbit Home directory
export ORBIT_HOME=/orbhome/prd

export OVERRIDE_PROPERTIES_FILE=$ORBIT_HOME/conf/orbit.properties

# (optional: to override logging configuration)Below line to load logback config from ORBIT_HOME/conf
#export JAVA_OPTIONS="$JAVA_OPTIONS -Dlogging.config=file:$ORBIT_HOME/conf/logback-spring.xml"

# Below line to set jasypt password if any properties are encrypted in orbit.properties
#export JAVA_OPTIONS="$JAVA_OPTIONS -Djasypt.encryptor.password=<YOUR-SECRET-HERE>"

######################## DO NOT CHANGE BELOW PROPERTIES

# Order of properties files
export JAVA_OPTIONS="$JAVA_OPTIONS -Dspring.config.location=classpath:/,file:$OVERRIDE_PROPERTIES_FILE"

# Configure Properties file into environment
export JAVA_OPTIONS="$JAVA_OPTIONS -Dorbit.properties.override.file=$OVERRIDE_PROPERTIES_FILE"

# Configure Orbit's Storage
export JAVA_OPTIONS="$JAVA_OPTIONS -Dorbit.reporting.home.path=$ORBIT_HOME"

# Parser definitions
export JAVA_OPTIONS="$JAVA_OPTIONS -Djavax.xml.parsers.SAXParserFactory=com.sun.org.apache.xerces.internal.jaxp.SAXParserFactoryImpl -Djavax.xml.parsers.DocumentBuilderFactory=com.sun.org.apache.xerces.internal.jaxp.DocumentBuilderFactoryImpl -Djavax.xml.transform.TransformerFactory=com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl -Djavax.xml.xpath.XPathFactory:http://java.sun.com/jaxp/xpath/dom=com.sun.org.apache.xpath.internal.jaxp.XPathFactoryImpl"