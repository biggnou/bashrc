### ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything (scp, rcp):
[ -z "$PS1" ] && return

# don't put duplicate lines in the history:
export HISTCONTROL=ignoreboth
# append to the history file and check window's size after each command:
shopt -s histappend
shopt -s checkwinsize
# immediately persist commands to HISTFILE
export PROMPT_COMMAND='history -a'
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=50000
export HISTFILESIZE=50000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# man pages more friendly (https://github.com/nickjj/dotfiles/blob/master/.config/zsh/.zprofile):
export LESS=-R
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESS_TERMCAP_mb=$'\e[1;31mm'    # begin blinking
export LESS_TERMCAP_md=$'\e[1;36m'     # begin bold
export LESS_TERMCAP_us=$'\e[1;332m'    # begin underline
export LESS_TERMCAP_so=$'\e[1;44;33m'  # begin standout-mode - info box
export LESS_TERMCAP_me=$'\e[0m'        # end mode
export LESS_TERMCAP_ue=$'\e[0m'        # end underline
export LESS_TERMCAP_se=$'\e[0m'        # end standout-mode


# set variable identifying the chroot you work in (used in the prompt below)
case "$TERM" in
    xterm*|gnome*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
        if [[ ${EUID} == 0 ]] ; then
            PS1='\[\033[01;31m\]arbeit\[\033[01;34m\] \W \$\[\033[00m\] '
        else
            PS1='\[\033[33m\]\h\[\033[33m\] \w \$\[\033[00m\] '
        fi
        ;;
    screen*)
        PROMPT_COMMAND='echo -ne "\033]0;SCREEN @${HOSTNAME%%.*}\007"'
        PS1='\u\[\033[1;33m\]@\[\033[0m\]\h\[\033[1;33m\]:\[\033[0m\] \w\$ '
        ;;
    *)
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
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
if [ -f '/usr/bin/colordiff' ]; then
    alias diff='colordiff'
fi
alias ll='ls -lh'
alias lld='ls -ld'
alias la='ls -lah'
alias cc='clear'
alias rs='reset'
alias less='less -n'
alias em='emacs -nw'
alias vi='vim "+set si"'
alias bc='bc -l'
alias sha1='openssl sha1'
alias mount='mount | column -t'
alias path='echo -e ${PATH//:/\\n}'
alias drun='docker run -it --user root --entrypoint=/bin/bash'
alias druns='docker run -it --user root --entrypoint=/bin/sh'
alias rmpyc="find . -type d -name '__pycache__' -exec rm -rf {} \;"
alias sshadd='eval `ssh-agent -s` ; ssh-add'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# useless but fun:
alias shitdown='shutdown -h now'
alias steve="jobs -l"
alias killl="echo That\'s a little bit overkill, isn\'t it?"

# kind of useful actually:
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../..'
alias .3='cd ../../..'
alias ....='cd ../../../..'
alias .4='cd ../../../..'
alias .....='cd ../../../..'
alias .5='cd ../../../../..'

# set PATH so it includes my private bin:
if [ -d ~/bin ] ; then
    PATH=~/bin:${PATH}
fi
# include go and sl
PATH=${PATH}:/usr/local/go/bin:/usr/games

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google/google-cloud-sdk/path.bash.inc' ]; then . '~/google/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google/google-cloud-sdk/completion.bash.inc' ]; then . '~/google/google-cloud-sdk/completion.bash.inc'; fi
if [ -f '~/.cargo/env']; then . "~/.cargo/env"; fi

# list tmux and screen sessions, in case:
echo tmux stuff: ; tmux list-se
echo screen stuff: ; screen -ls
