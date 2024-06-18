FROM gradle:8-jdk17-alpine AS build

WORKDIR /aws-pipeline-builder

COPY . .

RUN chmod +x gradlew
RUN ./gradlew build

FROM openjdk:17-jre-slim

WORKDIR /aws-pipeline-builder

COPY --from=build /aws-pipeline-builder/build/libs/*.jar aws-pipeline-builder.jar

ENTRYPOINT ["java", "-jar", "aws-pipeline-builder.jar"]

