FROM openjdk:8u131-jre-alpine
LABEL Author="Jimmy XU"
WORKDIR /usr/eureka-server
COPY target/eureka-server-0.0.1-SNAPSHOT.jar /usr/eureka-server/eureka-server.jar
COPY entrypoint.sh /usr/eureka-server
EXPOSE 8080
ENV INSTANCE_NAME=registry-server REPLICAS=1 NODE=1
ENTRYPOINT ["sh", "./entrypoint.sh"]