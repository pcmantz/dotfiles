#!/usr/bin/env zsh

if (( $+commands[zoxide] )); then
  # print "I am activating zoxide!"
  eval "$(zoxide init zsh)"
fi
