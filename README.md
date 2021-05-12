# kafka tools
This set of tools lets you quickly setup a local kafka (and zookeeper) cluster and get to work with it.
Apart from `create-topics.sh`, these scripts are mere convenience wrappers around [kafkacat](https://docs.confluent.io/platform/current/app-development/kafkacat-usage.html).

## start cluster
```bash
docker-compose up -d
```

## create a topic
```bash
docker run -i --network=host confluentinc/cp-kafka:5.2.4 /usr/bin/kafka-topics \
	--create \
	--bootstrap-server localhost:9092 \
	--replication-factor 3 \
	--partitions 4 \
	--config retention.ms=60000 \
	--topic the-topic
```

## list topics
```bash
docker run -i --network=host edenhill/kafkacat:1.5.0 -L -b localhost:9092
```

## start a consumer
```bash
docker run -it --network=host edenhill/kafkacat:1.5.0 -C -X topic.partitioner=murmur2_random -f 'partition=%p offset=%o >> key=%k value=%s\n' -b "localhost:9092" -t "the-topic"
```

## produce messages
```bash
echo "key:value" | docker run -i --network=host edenhill/kafkacat:1.5.0 -P -b localhost:9092 -t the-topic -K:
```

A slightly more structured message:
```bash
echo key:'{"uid":"'$(uuidgen)'", "message":"hello"}' | docker run -i --network=host edenhill/kafkacat:1.5.0 -P -b localhost:9092 -t the-topic -K:
```

## delete a topic
```bash
docker run -i --network=host confluentinc/cp-kafka:5.2.4 /usr/bin/kafka-topics \
	--delete \
	--bootstrap-server localhost:9092 \
	--topic the-topic
```

## shutdown cluster
```bash
docker-compose stop
```

## shutdown cluster and remove all data
```bash
docker-compose down
```
