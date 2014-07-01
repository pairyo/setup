#!/bin/bash - 
#===============================================================================
#
#          FILE: boost.sh
# 
#         USAGE: ./boost.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 06/30/2014 12:49
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
sudo apt-get install libboost-iostreams-dev

