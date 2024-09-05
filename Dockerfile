# Use Maven to build the project
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn clean package

# Use a lightweight server (Tomcat) to run the WAR file
FROM tomcat:9.0
COPY --from=build /app/target/java-maven-web-app.war /usr/local/tomcat/webapps/

# Expose port 8080
EXPOSE 8080

# Run Tomcat server
CMD ["catalina.sh", "run"]

