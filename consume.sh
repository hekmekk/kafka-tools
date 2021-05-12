#!/bin/bash

bootstrapServers=$1
topic=$2

if [[ -z "${bootstrapServers}" || -z "${topic}" ]]; then
	echo "Usage: ./${0} <bootstrap-servers> <topic>"
	exit 0
fi

docker run -it --network=host edenhill/kafkacat:1.5.0 -C -f 'partition=%p offset=%o >> key=%k value=%s\n' -b "${bootstrapServers}" -t "${topic}"

