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

sudo apt-get install libclang1-3.4 clang-3.4 clang \
clang-3.4 clang-3.4-doc libclang-common-3.4-dev  libclang-3.4-dev libclang1-3.4 libclang1-3.4-dbg libllvm-3.4-ocaml-dev  libllvm3.4 libllvm3.4-dbg lldb-3.4 llvm-3.4 llvm-3.4-dev llvm-3.4-doc  llvm-3.4-examples llvm-3.4-runtime clang-modernize-3.4 clang-format-3.4  python-clang-3.4 lldb-3.4-dev
sudo ln -s /usr/lib/llvm-3.4/lib/libclang.so.1 /usr/lib/llvm-3.4/lib/libclang.so

