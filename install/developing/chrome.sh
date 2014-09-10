#!/bin/bash - 
#===============================================================================
#
#          FILE: chrome.sh
# 
#         USAGE: ./chrome.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 07/04/2014 11:50
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
