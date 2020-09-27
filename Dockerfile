# Pull base image 
From tomcat:latest
# Adding file 
ADD webapp/target/webapp.war /usr/local/tomcat/webapps
# Adding Port
EXPOSE 8888
