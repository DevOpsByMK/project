FROM ubuntu
RUN apt update && apt install default-jdk -y && apt install maven git -y
RUN git clone https://github.com/DevOpsByMK/project.git
RUN cd project && mvn clean package

FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
COPY --from=0 /project/webapp/target/webapp.war /usr/local/tomcat/webapps/webapp.war
