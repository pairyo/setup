#!/bin/bash - 
#===============================================================================
#
#          FILE: insync.sh
# 
#         USAGE: ./insync.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 06/26/2014 21:42
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
echo "Installing insync..."
wget -O /tmp/insync.deb http://s.insynchq.com/builds/insync_1.0.29.31750_amd64.deb
sudo dpkg -i /tmp/insync.deb
echo "Finished installing insync!"

