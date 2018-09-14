#!/usr/bin/env fish
set fish_greeting

set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_DEFAULT_OPTS "--bind='ctrl-o:execute(emacsclient -c {})+abort'"
set -gx FZF_TMUX 1
set -gx FZF_COMPLETE 1
set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx PATH $HOME/.local/bin $HOME/.emacs.d/bin $PATH
alias l='exa -lha'
alias ll='exa -l'
alias ls='exa'
alias llt='exa -T'
alias llfu='exa -bghHliS --git'
alias prev='fzf --preview "bat --color always {}"'
alias g='git'
alias ghclone='git hub clone -t'
alias ghissue='git hub issue list'
