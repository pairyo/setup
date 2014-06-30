# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#startup{{{
#}}}
#yes
. /etc/profile.d/vte.sh
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.vim/bundle/gdbmgr/src

# append to the history file, don't overwrite it
shopt -s histappend
 
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=irgnoredups:erasedups
HISTTIMEFORMAT="%F-%M-%S --> "
HISTIGNORE="cd *":"ls *":"mkdir *"

export PATH=~/PhpStorm/bin/:~/potion/bin:~/bin:~/adt-bundle/sdk/platform-tools/:~/adt-bundle/sdk/tools/:$PATH
export PATH=~/bin/sbt/bin/:~/DCD/:$PATH
 
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
 
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
 
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
 
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
 
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
 
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
 
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
 
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
 
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
 
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
 
 
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
 
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
 
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
 
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# some more ls aliases
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias la='ls $LS_OPTIONS -a'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias lv="ls -F";
alias rm='rm -rf'
alias cp='cp -i'
alias mv='mv -i'


alias phpcsz='phpcs --standard=Zend '
alias cls='clear'
#alias netbeans='/home/dxks/netbeans-7.3rc2/bin/netbeans &'
alias a2reload='sudo service apache2 restart'
alias ssh_you='ssh you@192.168.0.101'

export PS1='\u@\h:\w\$ '
umask 022

# You may uncomment the following lines if you want `ls' to be colorized:

# Some more alias to avoid making mistakes:
ensiteIt(){
	sudo a2dissite *; 
	sudo a2ensite $1; 
	sudo service apache2 restart
}
logoutUser(){
    sudo pkill -u $1
}
swapScreen(){
    sudo xrandr --output LVDS1 --pos 1920x0 --output VGA1 --pos 0x0
}
switchInput(){
    action=`xinput list-props $1 | grep "Device Enabled" | sed 's/.*:\s*([0-9]*)/\1/' -r`
    if (( $action == "0" ))
    then 
        xinput enable $1
    else
        xinput disable $1
    fi
}
alias ensite=ensiteIt
shopt -s dotglob
alias watchMemory='watch "ps aux | sort -nrk 4 | head -n 40"'
alias watchCPU='watch "ps aux | sort -nrk 3 | head -n 40"'
alias replaceUnity='sudo DISPLAY=:0 unity --replace'
alias logOut="logoutUser $USER"
alias open="gnome-open"
alias switchKeyboard="switchInput 14"
alias switchMouse="switchInput 15"
alias vimall="gvim -p *.h *.cc makefile"
alias sourcenow="source ~/.bashrc"
alias bashe="vim ~/.bashrc"
alias vimrc="vim ~/.vimrc"
alias chperl="chmod u+x *.pl"
alias updatePersonWeb='ssh root@192.241.137.164 "cd /var/www/personalWeb; git pull;"'

alias findBinary='find . -name "*.o" -or -perm +111 -type f -not -name "*.py" -not -name "*.pl"  -not -name "*.sh"'
alias rmBinary='find . -name "*.o" -or -perm +111 -type f -not -name "*.py" -not -name "*.pl"  -not -name "*.sh" | xargs rm'
# added by Anaconda 1.9.1 installer
export PATH="~/anaconda/bin:$PATH"

#bitcoin
REG_ADDRESS=mxVJMaojtnRV9sUCoPVCSM4StCzDENKih9
export PATH="~/maicoin/bitcoin/src:$PATH"


#ctags

generateTags(){
    find . -regex ".*\.\(c\|h\|hpp\|cc\|cpp\)" -print | ctags --totals --recurse --extra="+qf" --fields="+i" -L -
}



#TMUX
TMUX_POWERLINE_DIR_HOME=~/jie/tmux-powerline
TMUX_POWERLINE_DIR_LIB=~/jie/tmux-powerline/lib
