#!/bin/bash

if [ -f /.redis_password_set ]; then
	echo "Redis password already set!"
	exit 0
fi

PASS=$(pwgen -s 32 1)
echo "=> Securing redis with a random password"
echo "requirepass $PASS" >> /etc/redis/redis.conf

echo "=> Done!"
touch /.redis_password_set

echo "========================================================================"
echo "You can now connect to this Redis server using:"
echo ""
echo "    redis-cli -a $PASS -h <host> -p <port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"