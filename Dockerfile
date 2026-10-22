# Use the official Tomcat 9 image with Java 11
FROM tomcat:9.0-jdk11-corretto

# Remove the default Tomcat welcome applications
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

# Set Tomcat HTTP port to 3000 at build time (Deplexo injects PORT=3000,
# and the container filesystem is read-only at runtime, so sed must happen here)
RUN sed -i 's/port="8080"/port="3000"/' /usr/local/tomcat/conf/server.xml

# Deploy the attendance app as the ROOT webapp so it serves at "/"
COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 3000
CMD ["catalina.sh", "run"]
