#!/bin/bash

if [ -f /.redis_password_set ]; then
	echo "Redis password already set!"
	exit 0
fi

PASS=${REDIS_PASS:-$(pwgen -s 32 1)}
_word=$( [ ${REDIS_PASS} ] && echo "preset" || echo "random" )
echo "=> Securing redis with a ${_word} password"
touch /etc/redis/redis_default.conf
echo "requirepass $PASS" >> /etc/redis/redis_default.conf

echo "=> Done!"
touch /.redis_password_set

echo "========================================================================"
echo "You can now connect to this Redis server using:"
echo ""
echo "    redis-cli -a $PASS -h <host> -p <port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
