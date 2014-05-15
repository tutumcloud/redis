FROM ubuntu:trusty
MAINTAINER Fernando Mayo <fernando@tutum.co>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C7917B12
RUN echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu quantal main" >> /etc/apt/sources.list
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server pwgen

# Add scripts
ADD run.sh /run.sh
ADD set_redis_password.sh /set_redis_password.sh
ADD set_redis_mode.sh /set_redis_mode.sh
RUN chmod 755 /*.sh

EXPOSE 6379
CMD ["/run.sh"]
