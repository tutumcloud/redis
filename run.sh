#!/bin/bash
if [ ! -f /.redis_mode_set ]; then
	/set_redis_mode.sh
fi
if [ ! -f /.redis_password_set ]; then
	/set_redis_password.sh
fi

exec /usr/bin/redis-server /etc/redis/redis_default.conf