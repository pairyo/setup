#!/bin/bash
git submodule update --init --recursive
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



