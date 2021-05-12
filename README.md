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
./list-topics.sh -b localhost:9092
```

## start a consumer
```bash
./consume.sh -f 'partition=%p offset=%o >> key=%k value=%s\n' -b "localhost:9092" -t "the-topic"
```

## produce messages
```bash
echo "key:value" | ./produce-message.sh -b localhost:9092 -t the-topic -K:
```

A slightly more structured message:
```bash
echo key:'{"uid":"'$(uuidgen)'", "message":"hello"}' | ./produce-message.sh -b localhost:9092 -t the-topic -K:
```

## shutdown cluster
```bash
docker-compose stop
```

## shutdown cluster and remove all data
```bash
docker-compose down
```
