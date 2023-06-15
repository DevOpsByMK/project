FROM ubuntu
RUN apt update && apt install default-jdk -y && apt install maven git -y
RUN git clone https://github.com/DevOpsByMK/webapplication.git
RUN cd webapplication && mvn clean package

FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
COPY --from=0 /webapplication/webapp/target/webapp.war /usr/local/tomcat/webapps/webapp.war
