#!/bin/sh
#Edited by Jie Feng
#~/install/installVim.sh

#PPA
sudo apt-add-repository ppa:thefanclub/grive-tools
sudo add-apt-repository ppa:atareao/atareao #google calendar
sudo add-apt-repository ppa:nvbn-rm/ppa #everpad

sudo apt-get update

#Python setup
sudo apt-get install python-pip 
sudo pip install urllib2

#Install softwares
sudo apt-get install vim vim-gnome tomboy exuberant-ctags\
    expect gparted \
    artha dict goldendict goldendict-wordnet \
    vlc-nox gimp apcalc\
    figlet\
    apt-file unrar\
    iftop bmon\
    calendar-indicator\
    everpad tmux\
    libreadline6 libreadline6-dev\
    libncurses5-dev\
    ack xfig


#Developing
sudo apt-get install cmake  bzr build-dep unity nux gnome-common libibus-1.0-dev libgtest-dev google-mock libxtst-dev libmrss0 

#Lamp
sudo apt-get install tasksel rake
sudo tasksel install lamp-server
sudo apt-get install php5-cgi
