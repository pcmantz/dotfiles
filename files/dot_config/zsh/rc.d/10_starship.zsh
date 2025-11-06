#!/usr/bin/env zsh

if (( $+commands[starship] )); then
  # print "I am activating starship!"
  eval "$(starship init zsh)"
fi
