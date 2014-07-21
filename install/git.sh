#!/bin/bash - 
#===============================================================================
#
#          FILE: git.sh
# 
#         USAGE: ./git.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 07/04/2014 12:21
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#Git setup
sudo apt-get install git
git config --global core.excludesfile ~/.gitignore_global
git config --global user.email "jiefeng.hopkins@gmail.com"
git config --global user.name "Jie Feng"
git config --global push.default simple
