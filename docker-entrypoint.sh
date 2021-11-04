#!/bin/bash
set -e

if [ ${K8S_ENV} ]; then
    LAST_POD_INDEX=$((${CLUSTER_SIZE} - 1))
    REPLICAS=""
    for i in $(seq 0 ${LAST_POD_INDEX}); do
      REPLICAS="${REPLICAS}http://${LMP_SERVICE_KEY}:${LMP_SERVICE_TOKEN}@${STATEFULSET_NAME}-${i}.${EUREKA_SERVICE_NAME}.${STATEFULSET_NAMESPACE}.${LMP_SERVICE_DOMAIN_SUFFIX}:${SERVER_PORT}/eureka/"
      if [ ${i} -lt ${LAST_POD_INDEX} ]; then
        REPLICAS="${REPLICAS},"
      fi
    done
    export EUREKA_CLIENT_SERVICE_URL_DEFAULTZONE=${REPLICAS}
    echo "EUREKA_CLIENT_SERVICE_URL_DEFAULTZONE=${REPLICAS}"
fi

exec java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -jar /app.jar
