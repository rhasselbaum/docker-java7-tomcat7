# A vanilla Tomcat 7 Docker container running under OpenJDK 7.

FROM ubuntu:14.04
MAINTAINER Rob Hasselbaum <rob@hasselbaum.net>

# Install Tomcat and create private CATALINA_BASE at '/tomcat' owned by the Tomcat user.
# Although Ubuntu creates a "tomcat7" user, we create our own (called "tcuser") so that 
# child images are not artificially coupled to a specific Tomcat version number and
# filesystem write access is limited to CATALINA_BASE.
RUN DEBIAN_FRONTEND=noninteractive \
 apt-get update && \
 apt-get install -y openjdk-7-jre-headless tomcat7 tomcat7-user && \
 groupadd -g 9000 tcuser && \
 useradd -d /tomcat -r -s /bin/false -g 9000 -u 9000 tcuser && \ 
 tomcat7-instance-create /tomcat && \
 chown -R tcuser:tcuser /tomcat

# Add volumes for volatile directories that aren't usually shared with child images.
VOLUME ["/tomcat/logs", "/tomcat/temp", "/tomcat/work"]

# Expose HTTP only by default.
EXPOSE 8080

# Workaround for https://bugs.launchpad.net/ubuntu/+source/tomcat7/+bug/1232258
RUN ln -s /var/lib/tomcat7/common/ /usr/share/tomcat7/common && \
 ln -s /var/lib/tomcat7/server/ /usr/share/tomcat7/server && \
 ln -s /var/lib/tomcat7/shared/ /usr/share/tomcat7/shared

# Use IPv4 by default and UTF-8 encoding. These are almost universally useful.
ENV JAVA_OPTS -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8

# All your base...
ENV CATALINA_BASE /tomcat

# Drop privileges and run Tomcat.
USER tcuser
CMD /usr/share/tomcat7/bin/catalina.sh run
