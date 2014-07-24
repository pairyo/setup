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

#push.sh setup
#gpg --symmetric < ~/.ssh/id_rsa  > github.gpg
gpg --decrypt < github.gpg > ~/.ssh/id_rsa
