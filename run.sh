#!/bin/bash
if [ ! -f /.redis_password_set ]; then
	/set_redis_password.sh
fi
/usr/bin/redis-server /etc/redis/redis_default.conf
