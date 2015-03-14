#!/bin/bash

if [ "${REDIS_PASS}" == "**Random**" ]; then
    unset REDIS_PASS
fi

# Set initial configuration
if [ ! -f /.redis_configured ]; then
    touch /etc/redis/redis_default.conf

    if [ "${REDIS_PASS}" != "**None**" ]; then
        PASS=${REDIS_PASS:-$(pwgen -s 32 1)}
        _word=$( [ ${REDIS_PASS} ] && echo "preset" || echo "random" )
        echo "=> Securing redis with a ${_word} password"
        echo "requirepass $PASS" >> /etc/redis/redis_default.conf
        echo "=> Done!"
        echo "========================================================================"
        echo "You can now connect to this Redis server using:"
        echo ""
        echo "    redis-cli -a $PASS -h <host> -p <port>"
        echo ""
        echo "Please remember to change the above password as soon as possible!"
        echo "========================================================================"
    fi

    unset REDIS_PASS

    for i in $(printenv | grep REDIS_); do
        echo $i | sed "s/REDIS_//" | sed "s/_/-/" | sed "s/=/ /" | sed "s/^[^ ]*/\L&\E/" >> /etc/redis/redis_default.conf
    done

    touch /.redis_configured
fi

exec /usr/bin/redis-server /etc/redis/redis_default.conf
