#!/bin/bash - 
set -o nounset                              # Treat unset variables as an error
#http://redis.io/topics/quickstart
pushd
cd ~/Downloads
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
sudo mkdir /etc/redis
sudo mkdir /var/redis
sudo cp utils/redis_init_script /etc/init.d/redis_6379
popd
#sudo cp redis.conf /etc/redis/6379.conf
sudo mv redis/6379.conf /etc/redis/
#sudo vi /etc/init.d/redis_6379
#REDIS_PORT
#Edit the configuration file, making sure to perform the following changes:
#Set daemonize to yes (by default it is set to no).
#Set the pidfile to /var/run/redis_6379.pid (modify the port if needed).
#Change the port accordingly. In our example it is not needed as the default port is already 6379.
#Set your preferred loglevel.
#Set the logfile to /var/log/redis_6379.log
#Set the dir to /var/redis/6379 (very important step!)
sudo update-rc.d redis_6379 defaults
/etc/init.d/redis_6379 start
#redis-cli save
#redis-cli shutdown
