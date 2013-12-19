FROM ubuntu:quantal
MAINTAINER Fernando Mayo <fernando@tutum.co>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C7917B12
RUN echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu quantal main" >> /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server pwgen

# Add scripts
ADD https://raw.github.com/tutumcloud/tutum-docker-redis/master/run.sh /run.sh
ADD https://raw.github.com/tutumcloud/tutum-docker-redis/master/set_redis_password.sh /set_redis_password.sh
RUN chmod 755 /*.sh

EXPOSE 6379
CMD ["/run.sh"]
