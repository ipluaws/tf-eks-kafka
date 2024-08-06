FROM maven:3.9.6 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn clean package -Dmaven.main.skip -Dmaven.test.skip -Dspring-boot.repackage.skip && rm -r target/
COPY src ./src
RUN mvn clean package -Dmaven.test.skip

FROM openjdk:21
COPY --from=build /app/target/producer-0.0.1-SNAPSHOT.jar /usr/local/lib/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/app.jar"]

