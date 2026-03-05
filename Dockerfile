FROM debian:bookworm-slim
RUN apt-get update && \
        apt-get install --assume-yes --no-install-recommends openjdk-17-jdk-headless
COPY gradle /src/gradle
COPY *.gradle gradlew  /src/
COPY src /src/src
RUN /src/gradlew --console=plain --no-daemon --project-dir /src/ bootJar
RUN cp /src/build/libs/NuulyAssessment-1.jar /app.jar
RUN rm -rf /src
ENTRYPOINT ["java", "-jar", "/app.jar"]
CMD ["--spring.config.location=classpath:application.yaml"]
