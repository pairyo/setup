#!/bin/bash - 
#===============================================================================
#
#          FILE: ppa.sh
# 
#         USAGE: ./ppa.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 06/28/2014 15:37
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error 
sudo add-apt-repository ppa:nvbn-rm/ppa         #everpad 
sudo add-apt-repository ppa:webupd8team/java    #Oracle-java
sudo apt-get update
