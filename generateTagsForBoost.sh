#!/bin/bash - 
#===============================================================================
#
#          FILE: generateTagsForBoost.sh
# 
#         USAGE: ./generateTagsForBoost.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 06/30/2014 13:22
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#apt-file list boost | grep -E -o '/usr/include/.*\.(h|hpp)' | grep -v '/usr/include/boost/typeof/' > ~/.vim/tags/boost-filelist
find /usr/include/boost/ | grep -v '/usr/include/boost/typeof/' > ~/.vim/tags/boost-filelist
ctags --sort=foldcase --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/tags/boost -L ~/.vim/tags/boost-filelist

