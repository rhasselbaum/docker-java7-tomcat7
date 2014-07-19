# A vanilla Tomcat 7 Docker container running under OpenJDK 7.

FROM ubuntu:14.04
MAINTAINER Rob Hasselbaum <rob@hasselbaum.net>

# Install Tomcat and create private CATALINA_BASE at '/tomcat7' owned by the Tomcat user.
RUN DEBIAN_FRONTEND=noninteractive \
 apt-get update && \
 apt-get install -y openjdk-7-jre-headless tomcat7 tomcat7-user && \
 tomcat7-instance-create /tomcat7 && \
 chown -R tomcat7:tomcat7 /tomcat7

# Expose HTTP only by default.
EXPOSE 8080

# Workaround for https://bugs.launchpad.net/ubuntu/+source/tomcat7/+bug/1232258
RUN ln -s /var/lib/tomcat7/common/ /usr/share/tomcat7/common && \
 ln -s /var/lib/tomcat7/server/ /usr/share/tomcat7/server && \
 ln -s /var/lib/tomcat7/shared/ /usr/share/tomcat7/shared

# Use IPv4 by default and UTF-8 encoding. These are almost universally useful.
ENV JAVA_OPTS "-Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8"

# Drop privileges and run Tomcat.
CMD sudo -u tomcat7 -- /bin/bash -c "/tomcat7/bin/startup.sh && tail -F /tomcat7/logs/catalina.out"
