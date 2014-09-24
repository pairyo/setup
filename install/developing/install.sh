#!/bin/bash - 
#**git, tmux
set -o nounset                              # Treat unset variables as an error
#Git setup
sudo apt-get install git tmux tomboy exuberant-ctags
git config --global core.excludesfile ~/.gitignore_global
git config --global user.email "jiefeng.hopkins@gmail.com"
git config --global user.name "Jie Feng"
git config --global push.default simple
git config --global alias.unstage 'reset HEAD --'

./chrome.sh
./rails.sh
./vim.sh
