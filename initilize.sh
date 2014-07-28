#!/bin/bash
rm ~/.vimrc ~/.bashrc ~/.tmux.conf 
rm .vim/ -rf
sleep 2
if [ ! -d ~/.vim ]; then
    git clone https://github.com/hophacker/.vim ~/.vim
fi

pushd .
cd ~/.vim
~/.vim/setPlugins.sh
popd


ln ~/jie/.bashrc -s ~/.bashrc
ln ~/jie/.tmux.conf -s ~/.tmux.conf
ln ~/.vim/.vimrc -s ~/.vimrc
ln ~/jie/.vrapperrc -s .vrapperrc
