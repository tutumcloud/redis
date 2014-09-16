#!/bin/bash
if [ "${REDIS_MODE}" == "**None**" ]; then
    unset REDIS_MODE
fi

if [ ! -f /.redis_configured ]; then
    if [ "$REDIS_MODE" == "LRU" ]; then
        echo "=> Configuring redis as a LRU cache"
        MAXMEMORY=${REDIS_MAXMEMORY:-"256mb"}
        touch /etc/redis/redis_default.conf
        echo "maxmemory $MAXMEMORY" >> /etc/redis/redis_default.conf
        echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis_default.conf
    else
        echo "=> Unknown $REDIS_MODE mode - ignoring"
    fi

    echo "=> Setting timeout to ${REDIS_TIMEOUT}"
    echo timeout ${REDIS_TIMEOUT} >> /etc/redis/redis_default.conf

    touch /.redis_configured
fi

if [ ! -f /.redis_password_set ]; then
        /set_redis_password.sh
fi

exec /usr/bin/redis-server /etc/redis/redis_default.conf
