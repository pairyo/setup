#!/bin/bash - 
#===============================================================================
#
#          FILE: tex.sh
# 
#         USAGE: ./tex.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 06/26/2014 22:17
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


echo "Installing Tex/Latex..."
sudo apt-get install texlive-full evince texmaker
echo "Finished installing Tex/Latex..."
