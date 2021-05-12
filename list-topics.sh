#!/bin/bash

bootstrapServers=$1

if [[ -z "${bootstrapServers}" ]]; then
	echo "Usage: ./${0} <bootstrap-servers>"
	exit 0
fi
docker run -it --network=host edenhill/kafkacat:1.5.0 -b ${bootstrapServers} -L
