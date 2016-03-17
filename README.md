tutum-docker-redis
==================

**This image will be deprecated soon. Please use the docker official image:** https://hub.docker.com/_/redis/

[![Deploy to Tutum](https://s.tutum.co/deploy-to-tutum.svg)](https://dashboard.tutum.co/stack/deploy/)

Base docker image to run a Redis server


Usage
-----

To create the image `tutum/redis`, execute the following command on the tutum-redis folder:

	docker build -t tutum/redis .


Running the Redis server
------------------------

Run the following command to start Redis:

	docker run -d -p 6379:6379 tutum/redis

The first time that you run your container, a new random password will be set.
To get the password, check the logs of the container by running:

	docker logs <CONTAINER_ID>

You will see an output like the following:

	========================================================================
	You can now connect to this Redis server using:

	    redis-cli -a 5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu -h <host> -p <port>

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu` is the password set.
You can then connect to Redis:

	redis-cli -a 5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu

Done!


Setting a specific password
---------------------------

If you want to use a preset password instead of a random generated one, you can
set the environment variable `REDIS_PASS` to your specific password when running the container:

	docker run -d -p 6379:6379 -e REDIS_PASS="mypass" tutum/redis

You can now test your deployment:

	redis-cli -a mypass

If you want to disable password authentication, you can set `REDIS_PASS` to `**None**`:

    docker run -d -p 6379:6379 -e REDIS_PASS="**None**" tutum/redis


Configuring Redis
-----------------

If you want to pass in any configuration variable to redis, set it as an environment variable with a `REDIS_` prefix. For example, if you want to set `tcp-keepalive 60`, execute the following:

	docker run -d -p 6379:6379 -e REDIS_TCP_KEEPALIVE=60 tutum/redis

For a full list of configuration options, check [this commented redis.conf file](https://raw.githubusercontent.com/antirez/redis/2.8/redis.conf)


Configuring Redis as a LRU cache
--------------------------------

In order to run Redis as a cache that will delete older entries when the memory fills up
provide the following additional environment variables:

	docker run -d -p 6379:6379 -e REDIS_MAXMEMORY_POLICY="allkeys-lru" -e REDIS_MAXMEMORY="256mb" tutum/redis

More info at [redis.io](http://redis.io/topics/lru-cache)


Configuring Redis to use AOF
----------------------------

If you want Redis to store data in a volume to prevent data from disappearing should you restart the container, set the following environment variables:

	docker run -d -p 6379:6379 -e REDIS_APPENDONLY=yes -e REDIS_APPENDFSYNC=always tutum/redis

Please note that this will impact performance. For a more lightweight persistence by saving every second instead of every instruction, use `REDIS_APPENDFSYNC=everysec` instead. More info at [redis.io](http://redis.io/topics/persistence)

**by http://www.tutum.co**
