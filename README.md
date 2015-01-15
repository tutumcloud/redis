tutum-docker-redis
==================

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

If you hope redis work without password, you can set `REDIS_PASS` to `**None**`:

    docker run -d -p 6379:6379 -e REDIS_PASS="**None**" tutum/redis


Configuring Redis as a LRU cache
--------------------------------

In order to run Redis as a cache that will delete older entries when the memory fills up
provide the following additional environment variables:

	docker run -d -p 6379:6379 -e REDIS_MODE="LRU" -e REDIS_MAXMEMORY="256mb" tutum/redis

where `REDIS_MODE` is `LRU` and `REDIS_MAXMEMORY` is the memory limit in which
Redis will start deleting the less recently used (LRU) keys.

More info at: http://redis.io/topics/lru-cache

**by http://www.tutum.co**
