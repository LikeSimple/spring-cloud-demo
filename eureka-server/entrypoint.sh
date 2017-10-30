#!/usr/bin/env sh

# 测试用参数
#LIMIT_IN_BYTES=268435456
#INSTANCE_NAME=registry-server
#NODE=1
#REPLICAS=1
#JAVA_OPTIONS="-Xms256M -Xmx256M"
#JAVA_APP_NAME="-jar eureka-server.jar"

if [ -z JAVA_OPTIONS ]
then
    JAVA_OPTS=${JAVA_OPTIONS}
else
    # 虚拟机固定参数
    JAVA_OPTS="-XX:+AggressiveOpts -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Djava.security.egd=file:/dev/./urandom -Dspring.profiles.active=docker"

    # 预设保留内存值
    RESERVED_MEGABYTES=64
    # 检测容器内存限制值
    LIMIT_IN_BYTES=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)

    # 如果启动容器时限制了内存参数则配置Java堆内存参数
    if [ "${LIMIT_IN_BYTES}" -ne "9223372036854771712" ]
    then

      LIMIT_IN_MEGABYTES=$(expr ${LIMIT_IN_BYTES} \/ 1048576)

      if [ ${RESERVED_MEGABYTES} -ge $(expr ${LIMIT_IN_MEGABYTES} \/ 4) ]
      then
        HEAP_SIZE=$(expr ${LIMIT_IN_MEGABYTES} \* 3 \/ 4)
      else
        HEAP_SIZE=$(expr ${LIMIT_IN_MEGABYTES} - ${RESERVED_MEGABYTES})
      fi

      JAVA_OPTS="${JAVA_OPTS} -Xms${HEAP_SIZE}m -Xmx${HEAP_SIZE}m"

    fi

    # 复制集群容器名称配置
    # 单节点：REPLICAS=1 NODE=1
    # 多节点：REPLICAS>1 NODE>=1 & NODE<=REPLICAS
    if [[ ${REPLICAS} -eq 1 && ${NODE} -eq 1 ]]
    then

      JAVA_PARAM_INSTANCE_NAME="-Deureka.instance.hostname=${INSTANCE_NAME}"
      JAVA_PARAM_REGISTER_WITH_EUREKA="-Deureka.client.registerWithEureka=false"
      JAVA_PARAM_FETCH_REGISTRY="-Deureka.client.fetchRegistry=false"
      JAVA_PARAM_DEFAULT_ZONE=""

    elif [[ ${REPLICAS} -gt 1 && ${NODE} -ge 1 && ${NODE} -le ${REPLICAS} ]]
    then

      JAVA_PARAM_INSTANCE_NAME="-Deureka.instance.hostname=${INSTANCE_NAME}-${NODE}"
      JAVA_PARAM_REGISTER_WITH_EUREKA=""
      JAVA_PARAM_FETCH_REGISTRY=""

      #配置多节点复制集群访问路径
      JAVA_PARAM_DEFAULT_ZONE=""

      for n in $(seq 1 ${REPLICAS})
      do
        if [ ${n} -ne ${NODE} ]
        then
          REPLICAS_URL=",http://${INSTANCE_NAME}-${n}:8080/eureka/"
          JAVA_PARAM_DEFAULT_ZONE=${JAVA_PARAM_DEFAULT_ZONE}${REPLICAS_URL}
        fi
      done

      JAVA_PARAM_DEFAULT_ZONE="-Deureka.client.service-url.defaultZone="${JAVA_PARAM_DEFAULT_ZONE:1}

    else

      echo "REPLICAS and NODE error！"
      echo "Single：REPLICAS=1 NODE=1"
      echo "HA：REPLICAS>1 NODE>=1 & NODE<=REPLICAS"
      echo "REPLICAS(${REPLICAS}) NODE(${NODE})"
      exit 1

    fi

    JAVA_OPTS="${JAVA_OPTS} \
      ${JAVA_PARAM_INSTANCE_NAME}  \
      ${JAVA_PARAM_REGISTER_WITH_EUREKA} \
      ${JAVA_PARAM_FETCH_REGISTRY} \
      ${JAVA_PARAM_DEFAULT_ZONE}"


fi

echo "JAVA_OPTIONS" ${JAVA_OPTS}

exec java \
  ${JAVA_OPTS} \
  ${JAVA_APP_NAME}