FROM debian:bookworm-slim
RUN apt-get update && \
        apt-get install --assume-yes --no-install-recommends openjdk-17-jdk-headless
# Copy wrapper first — only re-downloads gradle if wrapper config changes
COPY gradle /src/gradle
COPY gradlew /src/
RUN /src/gradlew --console=plain --no-daemon --version
# Copy build config — only re-resolves dependencies if build.gradle changes
COPY *.gradle /src/
RUN /src/gradlew --console=plain --no-daemon --project-dir /src/ dependencies
# Copy source — only rebuilds jar when code changes
COPY src /src/src
RUN /src/gradlew --console=plain --no-daemon --project-dir /src/ bootJar
RUN cp /src/build/libs/NuulyAssessment-1.jar /app.jar
RUN rm -rf /src
ENTRYPOINT ["java", "-jar", "/app.jar"]
CMD ["--spring.config.location=classpath:application.yaml"]
