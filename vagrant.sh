#!/bin/bash - 
set -o nounset                              # Treat unset variables as an error
ivagrant init ubuntu/trusty64; vagrant up --provider virtualbox

