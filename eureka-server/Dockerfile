FROM openjdk:8u151-jre-alpine
LABEL Author="Jimmy XU" EMAIL="zhen.xu@newtouch.cn"
RUN addgroup -S app && adduser -S -g app app
USER app
ARG PROJECT_NAME
ARG PROJECT_VERSION
ARG APP_NAME="-jar ${PROJECT_NAME}.jar"
WORKDIR /usr/${PROJECT_NAME}
COPY target/${PROJECT_NAME}-${PROJECT_VERSION}.jar /usr/${PROJECT_NAME}/${PROJECT_NAME}.jar
COPY entrypoint.sh /usr/${PROJECT_NAME}
EXPOSE 8080
ENV INSTANCE_NAME=${PROJECT_NAME} REPLICAS=1 NODE=1 JAVA_APP_NAME=${APP_NAME}
ENTRYPOINT ["sh", "./entrypoint.sh"]