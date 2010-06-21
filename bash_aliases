#!/bin/bash
# ~/.bash_aliases

PATH=~/bin:${PATH}

# emacs aliases
alias e="emacs"
alias ec="emacsclient"
alias enw="emacs -nw"
alias ect="emacsclient -t"

export EDITOR="mg"
export GIT_EDITOR="mg"

# perl aliases
alias lperl="perl -Mlocal::lib -Ilib"
alias lcpan=" eval $(perl -Mlocal::lib=~/perl5) && cpan"
