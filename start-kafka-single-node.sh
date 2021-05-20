#!/bin/sh
docker network create -d bridge single_node_kafka 2>/dev/null || true

# start zookeeper in detached mode
docker run -d --network=single_node_kafka --name local_zookeeper -h zoo1 -p 2181:2181 -e "ZOO_MY_ID=1" -e "ZOO_SERVERS=server.1=zoo1:2888:3888;2181" zookeeper:3.6.1 2>/dev/null || docker start local_zookeeper

# start kafka in detached mode
docker run -d --network=single_node_kafka --name local_kafka -h kafka1 -p 9092:9092 \
	-e "KAFKA_BROKER_ID=1" \
	-e "KAFKA_ZOOKEEPER_CONNECT=zoo1:2181" \
	-e "KAFKA_ADVERTISED_LISTENERS=LISTENER_DOCKER_INTERNAL://kafka1:19092,LISTENER_DOCKER_EXTERNAL://${DOCKER_HOST_IP:-127.0.0.1}:9092" \
	-e "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=LISTENER_DOCKER_INTERNAL:PLAINTEXT,LISTENER_DOCKER_EXTERNAL:PLAINTEXT" \
	-e "KAFKA_INTER_BROKER_LISTENER_NAME=LISTENER_DOCKER_INTERNAL" \
	-e "KAFKA_AUTO_CREATE_TOPICS_ENABLE=false" \
	confluentinc/cp-kafka:5.2.4 2>/dev/null || docker start local_kafka

echo "kafka start initiated successfully"
