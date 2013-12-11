tutum-docker-redis
====================

Base docker image to run a redis server


Usage
-----

To create the image `tutum/redis`, execute the following command on the tutum-redis folder:

	sudo docker build -t tutum/redis .


Running the redis server
--------------------------

Run the following command to start redis:

	ID=$(sudo docker run -d -p 6379 tutum/redis)


It will store the new container ID (like `d35bf1374e88`) in $ID. Get the allocated external port:

	sudo docker port $ID 6379


It will print the allocated port (like 6379). Test your deployment:

	redis-cli -p 6379 -h 127.0.0.1

Done!
