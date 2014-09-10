#!/bin/bash - 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E0F72778C4676186
sudo wget http://deb.playonlinux.com/playonlinux_quantal.list -O /etc/apt/sources.list.d/playonlinux.list
sudo apt-get update
sudo apt-get install playonlinux
