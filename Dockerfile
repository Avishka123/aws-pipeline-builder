FROM eclipse-temurin:17-jdk-focal AS build

WORKDIR /aws-pipeline-builder

COPY . .

RUN chmod +x gradlew
RUN ./gradlew build

FROM eclipse-temurin:17-jdk-focal

WORKDIR /aws-pipeline-builder

COPY --from=build /aws-pipeline-builder/build/libs/*.jar aws-pipeline-builder.jar

ENTRYPOINT ["java", "-jar", "aws-pipeline-builder.jar"]

