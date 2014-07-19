java7-tomcat7
=============

Creates a vanilla Tomcat 7 Docker container running under OpenJDK 7. Tomcat 7 is installed from the Ubuntu LTS repository so there are no external downloads. `CATALINA_BASE` is set to `/tomcat7`, which is created via Ubuntu's `tomcat7-instance-create` utility. Tomcat runs under the unprivileged `tomcat7` user, but this is done in the `CMD` so you can override the `CMD` if you want a root shell.

Port 8080 is exposed for HTTP. No other ports exposed.

There are no default apps or volumes so you can decide what parts of `CATALINA_BASE` should be baked into child images.
