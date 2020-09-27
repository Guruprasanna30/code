# Pull base image 
From tomcat:latest
# Maintainer 
ADD target/webapp.war /usr/local/tomcat/webapps
EXPOSE 8888
