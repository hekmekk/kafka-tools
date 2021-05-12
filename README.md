# kafka tools
This set of tools lets you quickly setup a local kafka (and zookeeper) cluster and get to work with it.
Apart from `create-topics.sh`, these scripts are mere convenience wrappers around [kafkacat](https://docs.confluent.io/platform/current/app-development/kafkacat-usage.html).

## start cluster
```bash
docker-compose up -d
```

## create a topic
```bash
./create-topic.sh \
	--bootstrap-server localhost:9092 \
	--replication-factor 3 \
	--partitions 4 \
	--config retention.ms=60000 \
	--topic the-topic
```

## list topics
```bash
./list-topics.sh localhost:9092
```

## start a consumer
```bash
./consume.sh localhost:9092 the-topic
```

## produce messages
```bash
./produce-message.sh localhost:9092 the-topic key:message
```

A slightly more structured message:
```bash
./produce-message.sh localhost:9092 the-topic key:'{"uid":"'$(uuidgen)'", "message":"hello"}'
```

## shutdown cluster
```bash
docker-compose stop
```

## shutdown cluster and remove all data
```bash
docker-compose down
```
