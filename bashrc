#!/usr/bin/env bash
# bashrc: bash initscript
#
# Customized for use by Paul Mantz

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more
# options don't overwrite GNU Midnight Commander's setting of
# `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary, update
# the values of LINES and COLUMNS.
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

# enable color prompt.  In the future, we can modify this to reveal
# valuable system information.
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and
        # such a case would tend to support setf rather than setaf.)
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

# Change the screen pane name if we are in a git directory
PROMPT_COMMAND='[[ -d $PWD/.git ]] && screen -X title "$(basename $(dirname $PWD)) $(basename $PWD)"'

# aliases and variable definitions
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# load some useful functions
if [ -f ~/.bash_functions ]; then
    source ~/.bash_functions
fi

# enable programmable completion features if they exist
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

#
# Only run the following code once.  Elsewise, it's going to completely wreck
# my path and look ugly, especially since I have a habit of nesting shells.
#

if [ -z $BASHRC_DONE ]; then

    # set up local environment
    if [ -f $HOME/.bashrc.local ]; then
        source $HOME/.bashrc.local
    fi

    export PATH=$HOME/bin:${PATH}
    export BASHRC_DONE=TRUE
fi
