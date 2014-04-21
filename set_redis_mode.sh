#!/bin/bash

if [ -f /.redis_mode_set ]; then
	echo "Redis mode already set!"
	exit 0
fi

if [ -n "$REDIS_MODE" ]; then
	if [ "$REDIS_MODE" == "LRU" ]; then
		echo "=> Configuring redis as a LRU cache"
		MAXMEMORY=${REDIS_MAXMEMORY:-"256mb"}
		touch /etc/redis/redis_default.conf
		echo "maxmemory $MAXMEMORY" >> /etc/redis/redis_default.conf
		echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis_default.conf
	else
		echo "=> Unknown $REDIS_MODE mode - ignoring"
	fi
fi

touch /.redis_mode_set
