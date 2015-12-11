#!/bin/bash

set +e

files=( .bashrc .tmux.conf .jslinhrc .jshintrc .emacs .zshrc )
ROOT=`pwd`

for file in ${files[*]}; do
  if [ -h $HOME/$file -o -e $HOME/$file ]; then
    rm $HOME/$file
  fi
  ln $ROOT/$file -s $HOME/$file
done

rm ~/.local/share/tomboy -rf
ln ~/Dropbox/tomboy -s $HOME/.local/share/tomboy
set -e
