FROM tomcat:8.0.46-jre8
ENV spring.datasource.username="username"
ENV spring.datasource.password="password"
ENV spring.datasource.url="url"
ENV spring.jpa.database-platform="database-platform"
ENV spring.datasource.driver-class-name="driver-class-name"
ENV spring.datasource.hikari.connection-test-query="connection-test-query"
ENV spring.datasource.hikari.maximum-pool-size="maximum-pool-size"
ENV spring.datasource.hikari.pool-name="pool-name"
ENV spring.jpa.show-sql="show-sql"
ENV spring.quartz.auto-startup="auto-startup"
ENV spring.quartz.wait-for-jobs-to-complete-on-shutdown="wait-for-jobs-to-complete-on-shutdown"
ENV spring.quartz.properties.org.quartz.jobStore.isClustered="isClustered"
ENV spring.quartz.properties.org.quartz.scheduler.instanceName="instanceName"
ENV server.servlet.context-path="context-path"
ENV server.servlet.session.timeout="timeout"
ENV orbit.token.auth.jot.expire.time="expire-time"
ENV logging.file.name.env="logging-file-name"
ENV logging.jobs.file.name.env="logging-jobs-file"
ENV logging.console.enabled="console-enabled"
ENV spring.mail.host="mail-host"
ENV spring.mail.port="mail-port"
ENV spring.mail.username="mail-username"
ENV spring.mail.password="mail-password"
ENV spring.mail.properties.mail.smtp.ssl.trust="mail-properties"
ENV spring.mail.protocol="mail-protocol"
ENV spring.mail.test-connection="test-connection"
ENV spring.mail.properties.mail.smtp.auth="smtp-auth"
ENV spring.mail.properties.mail.smtp.timeout="smtp-timeout"
ENV spring.mail.properties.mail.smtp.writetimeout="smtp-writetimeout"
ENV spring.mail.properties.mail.smtp.starttls.enable="smtp-starttls-enable"
ENV spring.mail.properties.mail.smtp.starttls.required="smtp-starttls-required"
ENV orbit.support.email="support-email"
ENV orbit.userlocales="userlocales"
ENV orbit.cuba.reporting.office.path="reporting-office-path"
ENV orbit.cuba.reporting.office.ports="reporting-office-ports"
ENV orbit.python.binary.path="python-binary-path"
ENV orbit.r.binary.path="r-binary-path"
ENV orbit.cuba.reporting.office.doc-formatter-timeout="doc-formatter-timeout"
ENV orbit.license.domain.name="license-domain-name"
ENV orbit.reporting.base.url="reporting-base-url"
ENV orbit.web-node.url="web-node-url"
ENV orbit.scheduler-node.url="scheduler-node-url"
ENV orbit.publisher-node.url="publisher-node-url"
ENV orbit.cors.allowed.origins="cors-allowed-origins"
ENV MY_POD_NAME="pod_name"
ARG user=orbit_user
ARG group=orbit_user
ARG uid=1000
ARG gid=1000
RUN groupadd -g ${gid} ${group} && useradd -u ${uid} -g ${group} -s /bin/sh ${user}
RUN chown ${user} -R /usr/local/tomcat
COPY ./tomcat-users-update.sh /usr/local/bin/tomcat-users-update.sh
COPY ./r-installation.sh /usr/src/r-installation.sh
COPY ./python-installation.sh /usr/src/python-installation.sh
COPY ./openoffice-installation.sh /usr/src/openoffice-installation.sh
RUN chmod a+x /usr/local/bin/tomcat-users-update.sh
RUN chmod a+x /usr/src/r-installation.sh
RUN chmod a+x /usr/src/python-installation.sh
RUN chmod a+x /usr/src/openoffice-installation.sh
RUN /usr/src/python-installation.sh
RUN /usr/src/r-installation.sh
RUN /usr/src/openoffice-installation.sh
USER ${user}
COPY ./reporting.war /usr/local/tomcat/webapps/reporting.war
COPY ./setenv.sh /usr/local/tomcat/bin/setenv.sh
COPY ./server.xml /usr/local/tomcat/conf/server.xml
COPY ./logging.properties /usr/local/tomcat/conf/logging.properties
RUN /usr/local/bin/tomcat-users-update.sh
CMD ["catalina.sh", "run"]