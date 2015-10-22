#!/usr/bin/env bash
# bashrc: bash initscript
#
# Customized for use by Paul Mantz

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

export HISTFILE="${HOME}/.history/$(date -u +%Y/%m/%d.%H.%M.%S)_${HOSTNAME}_$$"
mkdir -p $(dirname ${HISTFILE})
touch ${HISTFILE}

# append to the history file, don't overwrite it
shopt -s histappend

if [ -z "$PROMPT_COMMAND" ]; then
    export PROMPT_COMMAND=':'
fi
export PROMPT_COMMAND+='; history -a'

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

function set_color_prompt {
    local BLACK="\[\033[0;30m\]"
    local BLACKBOLD="\[\033[1;30m\]"
    local RED="\[\033[0;31m\]"
    local REDBOLD="\[\033[1;31m\]"
    local GREEN="\[\033[0;32m\]"
    local GREENBOLD="\[\033[1;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local YELLOWBOLD="\[\033[1;33m\]"
    local BLUE="\[\033[0;34m\]"
    local BLUEBOLD="\[\033[1;34m\]"
    local PURPLE="\[\033[0;35m\]"
    local PURPLEBOLD="\[\033[1;35m\]"
    local CYAN="\[\033[0;36m\]"
    local CYANBOLD="\[\033[1;36m\]"
    local WHITE="\[\033[0;37m\]"
    local WHITEBOLD="\[\033[1;37m\]"
    local ENDCOLOR="\[\033[00m\]"


    PS1="${WHITEBOLD}[\$(date -u +\"%Y-%m-%dT%H:%M:%SZ\")]\${ENDCOLOR}"
    PS1="${PS1} ${debian_chroot:+($debian_chroot)}"
    PS1="${PS1}${GREENBOLD}\u@\h${ENDCOLOR}"
    PS1="${PS1}:${BLUEBOLD}\w${ENDCOLOR}"
    PS1="${PS1}\n\$ "

    export PS1=$PS1
}

if [ "$color_prompt" = yes ]; then
    set_color_prompt
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
PROMPT_COMMAND+='; [[ -d $PWD/.git ]] && screen -X title "$(basename $(dirname $PWD)) $(basename $PWD)"'

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

# set up local environment
if [ -f $HOME/.bashrc.local ]; then
    source $HOME/.bashrc.local
fi
