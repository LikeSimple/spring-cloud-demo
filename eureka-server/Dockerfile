FROM openjdk:8u131-jdk-alpine
MAINTAINER Jimmy XU
ENV ACTIVE_PROFILE docker
ENV SERVICE_PORT 80
ENV
COPY target/eureka-server-0.0.1-SNAPSHOT.jar /usr/eureka-server/eureka-server.jar
WORKDIR /usr/eureka-server
EXPORT 80
ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap", "-jar", "eureka-server.jar"]