#!/bin/bash
# ~/.bash_aliases

export PATH=~/bin:${PATH}

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

# convenient ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# emacs aliases
export EMACSLOADPATH=~/elisp:~/.emacs.d:${EMACSLOADPATH}
alias e="emacs"
alias ec="emacsclient"
alias enw="emacs -nw"
alias ect="emacsclient -t"

# editor commands
export EDITOR="mg"
export GIT_EDITOR="mg"

# perl aliases
alias lperl="perl -Ilib"
# alias lperl="perl -Mlocal::lib -Ilib"
# alias lcpan=" eval $(perl -Mlocal::lib=~/perl5) && cpan"
