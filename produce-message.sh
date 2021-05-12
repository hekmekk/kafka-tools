#!/bin/bash

bootstrapServers=$1
topic=$2
message=$3

if [[ -z "${bootstrapServers}" || -z "${topic}" || -z "${message}" ]]; then
	echo "Usage: ./${0} <bootstrap-servers> <topic> <key:value>"
	exit 0
fi

echo "${message}" | docker run -i --network=host edenhill/kafkacat:1.5.0 -b "${bootstrapServers}" -t "${topic}" -P -Z -K:
