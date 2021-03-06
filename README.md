java7-tomcat7
=============

Creates a vanilla Tomcat 7 Docker container running under OpenJDK 7. Tomcat 7 is installed from the Ubuntu LTS repository so there are no external downloads. `CATALINA_BASE` is set to `/tomcat`, which is created via Ubuntu's `tomcat7-instance-create` utility. The process runs under an unprivileged user/group called `tcuser` (uid/gid 9000). We use that rather than the `tomcat7` user created by Ubuntu's Tomcat package in order to help decouple child images from the version number and to deny the user write access to directories outside of `$CATALINA_BASE`.

Port 8080 is exposed for HTTP.

The following volumes are defined, since typically you don't want child images to inherit these:

* /tomcat/logs
* /tomcat/work
* /tomcat/temp

Place your web apps under `/tomcat/webapps`. There are none installed by default.
