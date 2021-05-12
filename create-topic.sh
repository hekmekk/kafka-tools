#!/bin/bash

docker run -it --network=host confluentinc/cp-kafka:5.2.4 /usr/bin/kafka-topics --create $@

