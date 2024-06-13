FROM amazoncorretto:17-alpine-jdk AS build
WORKDIR /workspace/app

COPY . /workspace/app
RUN --mount=type=cache,target=/root/.gradle ./gradlew clean build --no-daemon -x test
RUN mkdir -p build/dependency && (cd build/dependency; jar -xf ../libs/*.jar)

FROM amazoncorretto:17-alpine-jdk
VOLUME /tmp
ARG DEPENDENCY=/workspace/app/build/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java", "-cp","app:app/lib/*", "com.example.aws.code.pipeline.Application"]