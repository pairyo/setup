#!/bin/bash - 
#===============================================================================
#
#          FILE: bitcoin.sh
# 
#         USAGE: ./bitcoin.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 06/26/2014 22:31
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
git clone https://github.com/bitcoin/bitcoin.git
cd bitcoin
./autogen.sh
sudo apt-get install libdb5.1++-dev libboost-all-dev libqt4-core libqt4-gui libqt4-dev
./configure --with-incompatible-bdb
