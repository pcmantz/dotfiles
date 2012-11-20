#!/bin/bash
# ~/.bash_aliases

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

DIFF='diff'
DIFFOPTS='-upd'
if [ -s `which colordiff` ]; then
    DIFF='colordiff'
fi
alias diff="${DIFF} ${DIFFOPTS}"

# convenient ls aliases
alias l='ls -CF'
alias ll='l -l'
alias la='l -A'
alias lal='l -Al'
alias lalh='l -Alh'

# editor commands

if [ -s `which zile` ]; then
    EDITOR=zile
elif [ -s `which mg` ]; then
    EDITOR=mg
else
    EDITOR=vi
fi
export EDITOR

# emacs aliases
alias e='emacs'
alias ec='emacsclient'
alias enw='emacs -nw'
alias ect='emacsclient -t'

# perl aliases
alias lperl='perl -I./lib -I./local'
alias pb='perlbrew'

# common command aliases
alias g='git'
alias fucking='sudo'

# ruby (and friends) aliases
alias be='bundle exec'
alias lruby='ruby -Ilib'

# misc
alias sha1='openssl sha1'
alias ports='netstat -tulanp'

alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'
