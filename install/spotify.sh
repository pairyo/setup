#!/bin/bash - 

# 1. Add this line to your list of repositories by
#    editing your /etc/apt/sources.list
echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list

# 2. If you want to verify the downloaded packages,
#    you will need to add our public key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59

# 3. Run apt-get update
apt-get update

# 4. Install spotify!
apt-get install spotify-client
