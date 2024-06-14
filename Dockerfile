# Stage 1: Build with Gradle (slim JDK image)
FROM gradle:8-jdk17-alpine AS builder

# Copy project files
COPY . /app

# Build the application with Gradle
WORKDIR /aws-pipeline-builder
RUN gradle build

# Stage 2: Slim runtime image (openjdk)
FROM openjdk:17-jre-slim

# Copy application JAR
COPY --from=builder /aws-pipeline-builder/build/libs/*.jar aws-pipeline-builder.jar

# Expose port (adjust if your application uses a different port)
EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]
