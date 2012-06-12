# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything (scp, rcp):
[ -z "$PS1" ] && return

# don't put duplicate lines in the history:
export HISTCONTROL=ignoreboth

# append to the history file and check window's size after each command:
shopt -s histappend
shopt -s checkwinsize

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# man pages more friendly:
export LESS_TERMCAP_mb=$(printf "\e[1;37m")
export LESS_TERMCAP_md=$(printf "\e[1;37m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;47;30m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[0;36m")

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt
case "$TERM" in
    xterm*|gnome*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    screen*)
        PROMPT_COMMAND='echo -ne "\033]0;SCREEN @${HOSTNAME%%.*}\007"'
        PS1='\u\[\033[1;33m\]@\[\033[0m\]\h\[\033[1;33m\]:\[\033[0m\] \w\$'
        ;;
    *)
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias zgrep='zgrep --color=auto'
fi

# enable programmable completion features:
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#those should go in .bash_aliases:
alias ll='ls -lh'
alias lld='ls -ld'
alias la='ls -lah'
alias cc='clear'
alias rs='reset'
alias less='less -n'
if [ -f '/usr/bin/colordiff' ]; then
    alias diff='colordiff'
fi
#alias em='emacs -nw'
alias lintme='spamassassin --lint'
alias tailq='mailq | tail'
alias blamavis='ps auxwwf | grep amavis'
function spamalyze() { if [[ $# = 1 ]]; then spamassassin -D 2>&1 < "$1" | less ; else echo "You should feed me with an email..."; fi }

# set PATH so it includes my private bin, hosts-tools and git_projects:
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi 
if [ -d ~/host-tools ] ; then
    PATH=~/host-tools:"${PATH}"
fi
if [ -d ~/git_projects/host-tools ]; then
    PATH=~/git_projects/host-tools:"${PATH}"
fi

export EDITOR="em"
export VISUAL="em"
export DEBEMAIL="alexandre.boyer@zerospam.ca"
alias debchange="debchange -D zerospam --force-distribution"
