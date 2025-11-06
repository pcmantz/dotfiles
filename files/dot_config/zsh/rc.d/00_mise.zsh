#!/usr/bin/env zsh

if (( $+commands[mise] )); then
  # print "I am activating mise!"
  eval "$(mise activate zsh)"
fi
