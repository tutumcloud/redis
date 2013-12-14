tutum-docker-redis
==================

Base docker image to run a Redis server


Usage
-----

To create the image `tutum/redis`, execute the following command on the tutum-redis folder:

	sudo docker build -t tutum/redis .


Running the Redis server
------------------------

Run the following command to start Redis:

	CONTAINER_ID=$(sudo docker run -d -p 6379 tutum/redis)

The first time that you run your container, a new random password will be set.
To get the password, check the logs of the container by running:

	sudo docker logs $CONTAINER_ID

You will see an output like the following:

	========================================================================
	You can now connect to this Redis server using:

	    redis-cli -a 5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu -h <host> -p <port>

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu` is the password set. To get
the allocated port to Redis, execute:

	sudo docker port $CONTAINER_ID 6379

It will print the allocated port (like 4751). You can then connect to Redis:

	 redis-cli -a 5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu -h 127.0.0.1 -p 4751

Done!
