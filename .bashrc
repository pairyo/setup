########## Functions
extract () { 
    if [ -f $1 ] ; then 
        case $1 in 
            *.tar.bz2) tar xvjf $1 ;; 
            *.tar.gz) tar xvzf $1 ;; 
            *.bz2) bunzip2 $1 ;; 
            *.rar) rar x $1 ;; 
            *.gz) gunzip $1 ;; 
            *.tar) tar xvf $1 ;; 
            *.tbz2) tar xvjf $1 ;; 
            *.tgz) tar xvzf $1 ;; 
            *.zip) unzip $1 ;; 
            *.Z) uncompress $1 ;; 
            *.7z) 7z x $1 ;; 
            *) echo "don't know how to extract '$1'..." ;; 
        esac 
    else 
        echo "'$1' is not a valid file!" 
    fi 
} 
pgrep() {
  pdfgrep "$1" . -nRi -C 200
}

########## Do nothing if not running interactively 
case $- in *i*) ;; *) return;; esac

########## nvm 
export NVM_DIR="$HOME/.nvm"
export NODE_PATH="$HOME/.npm:$NODE_PATH"
export NODE_ENV=production
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  
nvm use v0.12.2

########## rvm 
[ -e "~/.rvm/scripts/rvm" ] && . ~/.rvm/scripts/rvm

########## alias 
#alias emacs="/usr/local/Cellar/emacs/24.4/bin/emacs"
alias ninstall="npm install --save"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias runScala="scala -classpath . $1"
alias dict="dict $1 -d gcide wn" #dictionary
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vimbash="vim ~/.bashrc"
alias sourcebash="source ~/.bashrc"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

########## bash history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
HISTCONTROL=irgnoredups:erasedups
HISTTIMEFORMAT="%F-%M-%S --> "
HISTIGNORE="cd *":"ls *":"mkdir *"
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=100000
HISTFILESIZE=2000000

########## liquidprompt
#https://github.com/nojhan/liquidprompt
if [ -e ~/jie/liquidprompt/liquidprompt ]; then
  [[ $- = *i* ]] && source ~/jie/liquidprompt/liquidprompt
fi

########## bash completion
if ! shopt -oq posix; then
  [ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
  [ -f /etc/bash_completion ] && . /etc/bash_completion
  #for mac: brew install bash-completion, but too slow
  #[ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion
fi

########## exports 
export CLASSPATH=$JAVA_HOME/lib
export EDITOR=vim
export PATH="/usr/local/bin:$HOME/.rvm/bin:$HOME/.rvm/bin:$PATH"

########## JAVA
########## Other
if [ "$(uname)" == "Darwin" ]; then
  export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
  if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
      . /opt/local/etc/profile.d/bash_completion.sh
  fi
  alias ls='ls -G'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  export JAVA_HOME=/usr/lib/jvm/java-8-oracle
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      #alias dir='dir --color=auto'
      #alias vdir='vdir --color=auto'
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
      alias open="xdg-open"
  fi
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  echo "hey"
fi


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#set -o vi
#xinput set-prop 15 "Device Enabled" 1
[[ -e ~/jie/local.sh ]] && . ~/jie/local.sh
[ "$DISPLAY" ] && xset b 100
