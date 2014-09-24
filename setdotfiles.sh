#!/bin/bash
rm ~/{.bashrc,.tmux.conf,.jslinhrc,.jshintrc}
rm ~/.local/share/tomboy -rf
ln ~/jie/.bashrc -s ~/.bashrc
ln ~/jie/.jshintrc -s ~/.jshintrc
ln ~/jie/.tmux.conf -s ~/.tmux.conf
ln ~/Dropbox/tomboy -s ~/.local/share/tomboy
