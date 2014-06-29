#!/bin/bash - 
#===============================================================================
#
#          FILE: fcitx.sh
# 
#         USAGE: ./fcitx.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/26/2014 01:15
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
sudo add-apt-repository ppa:wengxt/fcitx-nightly
sudo apt-get update
sudo apt-get install fcitx fcitx-config-gtk fcitx-sunpinyin
sudo apt-get install fcitx-table-all
sudo apt-get install im-switch
im-switch -s fcitx -z default
sudo apt-get install ttf-arphic-uming
