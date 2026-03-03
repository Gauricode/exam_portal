# -------- Build stage --------
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

COPY src ./src
RUN mvn -DskipTests clean package

# -------- Runtime stage --------
FROM tomcat:9.0-jdk21-temurin

ENV PORT=8080

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/untitled-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
COPY render-start.sh /usr/local/bin/render-start.sh
RUN chmod +x /usr/local/bin/render-start.sh

EXPOSE 8080
CMD ["/usr/local/bin/render-start.sh"]
