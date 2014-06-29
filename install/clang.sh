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
#       CREATED: 04/05/2014 22:28
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

sudo apt-get install libclang1-3.4 clang-3.4 clang
sudo ln -s /usr/lib/llvm-3.4/lib/libclang.so.1 /usr/lib/llvm-3.4/lib/libclang.so
