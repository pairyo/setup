#!/bin/bash - 
set -o nounset                              # Treat unset variables as an error
rm ~/.bashrc ~/.tmux.conf ~/.vrapperrc ~/.tmuxinator -rf
ROOT=`pwd`
ln $ROOT/.bashrc -s $HOME/.bashrc
ln $ROOT/.tmux.conf -s $HOME/.tmux.conf
ln $ROOT/.vrapperrc -s $HOME/.vrapperrc
ln $ROOT/.tmuxinator -s $HOME/.tmuxinator
