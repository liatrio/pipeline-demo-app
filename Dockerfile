FROM tomcat:9.0.4-jre8-alpine
COPY target/personal-banking.war /usr/local/tomcat/webapps/personal-banking.war
EXPOSE 8080
