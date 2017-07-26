#!/usr/bin/bash

export HOME=/root
export MANTA_KEY_ID=$(ssh-keygen -E md5 -l -f /root/.ssh/sup_manta.key | cut -b 10-56)
export MANTA_URL=https://us-east.manta.joyent.com
export MANTA_USER=joyentsup
export MANTA_SUBUSER=sup_manta

OBJ=$1
FILE=$2
MMD5=$(mmd5 $OBJ 2>/dev/null | cut -f 1 -d " ")
MD5=$(md5sum $FILE 2>/dev/null | cut -f 1 -d " ")

if [ -z "$MMD5" ]; then
	echo Object not found.
	exit 1
fi

if [ -z "$MD5" -o "$MMD5" != "$MD5" ]; then
	mget -o $FILE $OBJ 2>/dev/null
	if [ $? -gt 0 ]; then
		echo Error getting object.
		exit 1
	fi
fi

exit 0
