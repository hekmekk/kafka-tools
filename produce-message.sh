#!/bin/bash

docker run -i --network=host edenhill/kafkacat:1.5.0 -P "${@}"
