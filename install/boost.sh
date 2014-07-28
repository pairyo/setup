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
# Get the version of Boost that you require. This is for 1.54 but feel free to change or manually download yourself
wget -O boost_1_55_0.tar.gz http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz/download
tar xzvf boost_1_55_0.tar.gz
cd boost_1_55_0/
# Now we are inside the boost directory we can get the installation script and execute it.
# NOTE: READ THE SCRIPT FIRST
wget https://dl.dropbox.com/u/88131281/install_boost.sh
chmod +x install_boost.sh
./install_boost.sh
rm boost_1_55_0.tar.gz boost_1_55_0/ -r
