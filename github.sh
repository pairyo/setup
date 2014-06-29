#!/bin/bash -f
#===============================================================================
#
#          FILE: github.sh
# 
#         USAGE: ./github.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 06/29/2014 14:02
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

mkdir ~/generated

#push.sh setup
gpg --output ~/generated/push.sh  --decrypt ~/jie/install/push.sh.gpg
chmod a+x ~/generated/push.sh

