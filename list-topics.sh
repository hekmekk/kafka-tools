#!/bin/bash

docker run -it --network=host edenhill/kafkacat:1.5.0 -L "${@}"
