# Pull base image 
From tomcat:latest
# Maintainer 
COPY target/webapp.war /usr/local/tomcat/webapps
EXPOSE 8888
