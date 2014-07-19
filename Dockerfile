# Pulls down a Java runtime and tools atop an Ubuntu LTS base image.

FROM rhasselbaum/java7-base
MAINTAINER Rob Hasselbaum <rob@hasselbaum.net>

RUN DEBIAN_FRONTEND=noninteractive \
 apt-get install -y tomcat7 tomcat7-user && \
 tomcat7-instance-create /tomcat7 && \
 chown -R tomcat7:tomcat7 /tomcat7

CMD sudo -u tomcat7 -- /bin/bash -c "/tomcat7/bin/startup.sh && tail -F /tomcat7/logs/catalina.out"
