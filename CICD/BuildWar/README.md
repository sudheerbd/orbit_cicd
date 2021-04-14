# OrbitReporting Build Scripts

This repository contains build scripts for orbit application and its dependencies.

Following projects gets built with the build scripts

  - License proxy
  - Marketplace Integration
  - Orbit extn
  - Orbit Reporting
  - Orbit Servers

# Jenkins Configuration

* BitBucket URL : ```` https://bitbucket.org/orbitanalytics/buildscripts.git ````
* Additional behaviours : ````Check out to a sub-directory````
* Local subdirectory for repo : ````buildscripts````
* Script Path : ````Jenkinsfile````

# Jenkinsfile structure

##### Parameters

* serverType
    * tomcat
    * weblogic
* buildType
    * trunk
    * branch
* branchName
* bitbucketCreds
* generateServers


##### Stages
* Start
* GIT checkout (parallel) 
    * Licensing proxy checkout
    * Market place integration checkout
    * Orbitreporting checkout
* Builds      
    * Orbit dependents Builds (parallel)
        * Licensing proxy build
        * Market place integration build
    * Orbit reporting build
    * Orbit extn build
    * Add extn lib for tomcat
    * Add extn lib for weblogic
    * Orbit servers build
        * Servers copy 
            * Generate servers
                * Orbit commons server build
                * Orbit publisher server build
                * Orbit scheduler server build
        * Cleanup temp directory
* End