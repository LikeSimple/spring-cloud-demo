# Spring Cloud Demo

## 开发环境准备
1. Docker 17+
2. Maven 3+
3. Java 1.8+
4. IDEA 2016+

## 本地运行环境准备
1. Consul

`docker pull consul:0.9.2`

`docker run -d --name=dev-consul -p: 8500:8500 consul:0.9.2`

2. RabbitMQ

`docker pull rabbitmq:3.6.10-management-alpine`

`docker run --name spring-cloud-demo-rabbitmq -d --hostname my-rabbit -p 5672:5672 -p 15672:15672 -e RABBITMQ_DEFAULT_USER=rabbit -e RABBITMQ_DEFAULT_PASS=123456 rabbitmq:3.6.10-management-alpine`

3. hosts文件 

    127.0.0.1       registry-server-1  #port=8759
    
    127.0.0.1       registry-server-2  #port=8760
    
    127.0.0.1       registry-server-3  #port=8761

4. MySQL

`docker pull mysql:5.7.18`

`docker run --name spring-cloud-demo-mysql -d -p3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql:5.7.18`

## 项目说明

均为标准SpringBoot构建项目，可使用 `mvn spring-boot:run -Dserver.port=[port]`形式进行启动。或者在package打包后使用java -jar xxx.jar形式。
- ### eureka-server 
    
    用于启动服务发现模块 Eureka，必须作为第一个启动项目，后续项目均依赖于此。
    
    Maven启动命令

    `mvn spring-boot:run -Dserver.port=[8759|8760|8761]`

    使用不同端口启动多实例则为本地集群模式
    
- ### service-hello

    演示后台服务提供模块，提供/hi入口，使用Eureka注册模块
    
- ### service-hi-consule

    演示后台服务提供模块，提供/hi入口，使用Consul注册模块

- ### service-ribbon

    演示ribbon负载均衡模块，用于聚合后台服务提供模块
    
- ### service-feign

    演示feign声明式HTTP客户端模块，简化后台接口调用模式
    
- ### service-zuul

    演示zuul边界API路由模块，可使用Spring Security来提供身份验证等服务
    
- ### config-server

    演示配置服务提供模块，以Git库作为数据源

- ### config-client

    演示配置服务消费者，包含热更新数据

- ### turbine-server

    演示基于Hystrix的实时聚合监控服务

- ### sleuth-server

    演示基于Sleuth的链路跟踪服务


