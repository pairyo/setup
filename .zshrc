# Path to your oh-my-zsh installation.
# source $HOME/.bash_profile
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:~/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="$HOME/.rvm/gems/ruby-2.2.3/bin:$HOME/Android/sdk/platform-tools:$HOME/Android/sdk/tools/:$PATH"
export NVM_DIR="/home/hophacker/.nvm"
rvm use ruby-2.2.3
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
nvm use 0.12.7
export EDITOR="env LC_CTYPE=zh_CN.UTF-8 emacs"
alias emacs=$EDITOR

# git alias
git config --global alias.df "diff HEAD^ HEAD"
git config --global alias.caa "commit -a --amend"
DISABLE_AUTO_TITLE=true
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
function swap() {
  if [ $# -ne 2 ]; then
    echo "Usage: swap file1 file2"
  else
    local TMPFILE=$(mktemp)
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
  fi
}

alias vsecrets='vim ~/pairyo/docs/secrets.sh'
export ANDROID_HOME='/home/hophacker/Android/sdk'
alias open=xdg-open
function _sync(){
  server=$1
  if [ "$server" = "test" -o "$server" = "production" ]; then
    branch=$2
    if [ "$branch" = "" ]; then
      branch=master
    fi
    git checkout $branch
    git add .; gca! --no-edit; 
    gpu $branch --force; 
    ssh game_$server "cd ~/tianhei; git checkout -f $branch; git fetch upstream $branch; git reset upstream/$branch --hard;"
  fi 
}
alias sync=_sync
QINIU_ACCESS_KEY=l6Rf0LgQDgpSwjdXr_MgsCynhsofRM7W2dwvIOXO
