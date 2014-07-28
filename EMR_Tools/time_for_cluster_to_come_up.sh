#!/bin/bash - 
#===============================================================================
#
#          FILE: time_for_cluster_to_come_up.sh
# 
#         USAGE: ./time_for_cluster_to_come_up.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 07/25/2014 13:33
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


time while [ "$waiting" != "0" ]; do
    sleep 3
    elastic-mapreduce --describe j-2GCUXUB6VH7Y |grep "State.*WAITING" > /dev/null
    waiting=$?
done

