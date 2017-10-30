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
    
    进入本项目根目录
    
    Maven启动命令

    `mvn spring-boot:run -Dserver.port=[8759|8760|8761]`

    使用不同端口启动多实例则为本地集群模式
    
    本项目中整合了Maven-Dockerfile插件，因此可以使用mvn命令来编译Docker镜像
    如何具体使用该插件功能请查阅[dockerfile-maven](https://github.com/spotify/dockerfile-maven)
    
    `mvn dockerfile:build` 或者 `mvn clean package`
    
    启动容器
    
    （单点模式）
    
    `docker run --name eureka-server -d -p 8080:8080 eureka-server:1.0.0`
    
    （集群模式）
    
    节点一：`docker run --name eureka-server-1 -e REPLICAS=3 -e NODE=1 -d --network spring-cloud -p 8081:8080 eureka-server:1.0.0`
    节点二：`docker run --name eureka-server-2 -e REPLICAS=3 -e NODE=2 -d --network spring-cloud -p 8082:8080 eureka-server:1.0.0`    
    节点三：`docker run --name eureka-server-3 -e REPLICAS=3 -e NODE=3 -d --network spring-cloud -p 8083:8080 eureka-server:1.0.0`
    
    其中容器名称数字编号必须与NODE一致，同时容器间必须在一个网络内（保证可以互相访问）
    
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

- ### server-sso

    演示基于Spring Security OAuth的SSO项目
    
    启动本项目，然后可以使用如下命令获取用户Token
    
    `curl -XPOST "web_app:web_secret@localhost:9999/oauth/token" -d "grant_type=password&username=reader&password=reader"`
    
    `{"access_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MDg4MTE0MTksInVzZXJfbmFtZSI6InJlYWRlciIsImF1dGhvcml0aWVzIjpbIkZPT19SRUFEIl0sImp0aSI6ImMzNTUyNGYwLTRkNmEtNDEyZi05MWVlLTFhNDJmNzZiY2VlNSIsImNsaWVudF9pZCI6IndlYl9hcHAiLCJzY29wZSI6WyJGT08iXX0.qwtQh-us66xjMQaBkCVPnly2B4Rj9mHcsxvB5b7Iy4zzwW63AH5xV9dmdx6anyXBCxzPExMuB8hk32IyljeiV03G8rd9ENErWscj7XJ1mCqb3ATt_oSwGwnSUf9-hmN1GQ9mBAwV_N-qucN1qfoONL-W-y6JXG6R8uTdno97AsSPakb9DrW6alrtwxF29ivNAq9xkeZdCx9eJC6GuWek9_9D44cDxO3EhkhDvVfFcSrwZB0Quh2EdFhQr8LYnTQ030Z_V_Vu32oIP8KNy1mwguOuk4KpFkSiNo_QbQk47e6W-wJGKWQmyrrk9EN8VX7WBvENNkqCY0Q_ugWw6mBEtg","token_type":"bearer","refresh_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJyZWFkZXIiLCJzY29wZSI6WyJGT08iXSwiYXRpIjoiYzM1NTI0ZjAtNGQ2YS00MTJmLTkxZWUtMWE0MmY3NmJjZWU1IiwiZXhwIjoxNTExMzYwMjE5LCJhdXRob3JpdGllcyI6WyJGT09fUkVBRCJdLCJqdGkiOiJmN2RiMDdmOC01NjI5LTQ5ODYtYTBkYy01MzJkMGYzMjEyZTEiLCJjbGllbnRfaWQiOiJ3ZWJfYXBwIn0.VoFuhsGYoHTzGFjjPaeNDpGoCkkXD_RjbvCl6Ce7H_DYZcOePtDu9l3TsiaRmtWW3LvqwxPWcTD4nSWlSv8IcfC_KimBnk9dsvGs4bM13vesq54vNc23DXsKRODV_mIBcycX7xxm9XxOQHgwdUmMbSgzqfRO4vAWeiUYhyqEMt-dPLziVHzzDqIjDMQ7MNBnwNEhAuZfL0B3ELE4GgeV6Y7aH8mA2-Zs7eX5DtG9ibRlTnn8CDAdJepQh1eGjpaPHr-qn-UgFBL1_P-rqnZwmajbir3GVkJfzi8z0FcWA4u5wPGHDuQJOhAvK-6OsCLrb-1ThSvrySZ-j0bIHbZykQ","expires_in":43199,"scope":"FOO","jti":"c35524f0-4d6a-412f-91ee-1a42f76bcee5"}`
    
    在启动整个SpringCloudDemo后，就可以使用如下命令
    ```
    TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MDg4MTE0MTksInVzZXJfbmFtZSI6InJlYWRlciIsImF1dGhvcml0aWVzIjpbIkZPT19SRUFEIl0sImp0aSI6ImMzNTUyNGYwLTRkNmEtNDEyZi05MWVlLTFhNDJmNzZiY2VlNSIsImNsaWVudF9pZCI6IndlYl9hcHAiLCJzY29wZSI6WyJGT08iXX0.qwtQh-us66xjMQaBkCVPnly2B4Rj9mHcsxvB5b7Iy4zzwW63AH5xV9dmdx6anyXBCxzPExMuB8hk32IyljeiV03G8rd9ENErWscj7XJ1mCqb3ATt_oSwGwnSUf9-hmN1GQ9mBAwV_N-qucN1qfoONL-W-y6JXG6R8uTdno97AsSPakb9DrW6alrtwxF29ivNAq9xkeZdCx9eJC6GuWek9_9D44cDxO3EhkhDvVfFcSrwZB0Quh2EdFhQr8LYnTQ030Z_V_Vu32oIP8KNy1mwguOuk4KpFkSiNo_QbQk47e6W-wJGKWQmyrrk9EN8VX7WBvENNkqCY0Q_ugWw6mBEtg
    curl -H "Authorization: Bearer $TOKEN" -i "http://localhost:8769/api-a/hi?name=JImmy"
    HTTP/1.1 200 
    X-Content-Type-Options: nosniff
    X-XSS-Protection: 1; mode=block
    Cache-Control: no-cache, no-store, max-age=0, must-revalidate
    Pragma: no-cache
    Expires: 0
    X-Frame-Options: DENY
    X-Application-Context: service-zuul:8769
    Date: Mon, 23 Oct 2017 14:38:31 GMT
    Content-Type: text/plain;charset=UTF-8
    Transfer-Encoding: chunked
    
    Hi JImmy, I am from port:8762
    
    ```