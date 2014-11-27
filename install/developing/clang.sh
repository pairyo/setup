#!/bin/bash - 
#===============================================================================
#
#          FILE: clang.sh
# 
#         USAGE: ./clang.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/27/2014 16:26
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
pushd .
cd ~/Downloads
wget http://llvm.org/releases/3.5.0/cfe-3.5.0.src.tar.xz 
tar axvf cfe-3.5.0.src.tar.xz 
sudo mv clang+llvm-3.5.0-x86_64-linux-gnu /usr/local/clang
popd 

