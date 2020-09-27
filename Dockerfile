# Pull base image 
From tomcat:latest
# Adding file 
ADD webapp/target/webapp.war /usr/local/tomcat/webapps
EXPOSE 8888
