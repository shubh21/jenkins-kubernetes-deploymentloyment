# Stage 1: Build the application
FROM amazoncorretto:17 AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# Stage 2: Create the final production image
FROM amazoncorretto:17-alpine
WORKDIR /app

# Copy only the built JAR file from the build stage
COPY --from=build /app/target/jenkins-java-app-1.0-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application with production-ready JVM options
ENTRYPOINT ["java", "-Xms512m", "-Xmx1024m", "-XX:+UseG1GC", "-jar", "app.jar"]
