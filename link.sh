#!/bin/bash - 
set -o nounset                              # Treat unset variables as an error
rm ~/.bashrc ~/.tmux.conf ~/.vrapperrc ~/.tmuxinator -rf
ln ~/jie/.bashrc -s ~/.bashrc
ln ~/jie/.tmux.conf -s ~/.tmux.conf
ln ~/jie/.vrapperrc -s ~/.vrapperrc
ln ~/jie/.tmuxinator -s ~/.tmuxinator
