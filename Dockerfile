# -------- Build stage --------
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

COPY src ./src
RUN mvn -DskipTests clean package

# -------- Runtime stage --------
FROM tomcat:9.0-jdk21-temurin

# Render provides PORT dynamically; Tomcat defaults to 8080.
# We'll map server.xml to use ${PORT} at startup.
ENV PORT=8080

# Remove default webapps and deploy app as ROOT
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/untitled-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Configure Tomcat connector port dynamically from $PORT
RUN sed -i 's/port="8080"/port="${PORT}"/g' /usr/local/tomcat/conf/server.xml

EXPOSE 8080
CMD ["catalina.sh", "run"]
