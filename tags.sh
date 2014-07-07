#!/bin/bash - 
#===============================================================================
#
#          FILE: tags.sh
# 
#         USAGE: ./tags.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 06/30/2014 12:28
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
gcc -M -I /usr/include/boost $* | sed -e 's/[\\ ]/\n/g' | \
    sed -e '/^$/d' -e '/\.o:[ \t]*$/d' | \
    ctags -L - --c++-kinds=+p --fields=+iaS --extra=+q

