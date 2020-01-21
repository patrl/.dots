# clone zplugin if not already in home dir
if [[ ! -d ~/.zplugin ]];then
    mkdir -p ~/zplugin && git clone https://github.com/zdharma/zplugin ~/.zplugin/bin
fi

source ~/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# completions
zplugin ice wait"0" blockf
zplugin light zsh-users/zsh-completions

# fish-style autosuggestions
zplugin ice wait"0" atload"_zsh_autosuggest_start"
zplugin light zsh-users/zsh-autosuggestions

# syntax highlighting
zplugin ice wait"0" atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

# fzf (this one is uber-important to my workflow!)
zplugin ice from"gh-r" as"program"
zplugin load junegunn/fzf-bin

# the official fzf zsh plugin + the fzf-tmux script
zplugin ice multisrc"shell/{completion,key-bindings}.zsh" pick"bin/fzf-tmux" as"program"
zplugin light junegunn/fzf

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' # use fd instead of find (it's much faster)
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" # use fd for ctrl-t too
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(emacsclient -c {})+abort'"
export FZF_TMUX=1
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

# dracula color-scheme for fzf
export FZF_DEFAULT_OPTS='
  --color=bg+:#44475a,bg:#282a36,spinner:#50fa7b,hl:#44475a
  --color=fg:#f8f8f2,header:#ff5555,info:#ff5555,pointer:#50fa7b
  --color=marker:#ff5555,fg+:#f8f8f2,prompt:#50fa7b,hl+:#44475a
'

zplugin ice as"program" cp"src/capture.sh -> capture" pick"capture"
zplugin load buhman/capture

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure
export PURE_PROMPT_SYMBOL="λ"
export PURE_PROMPT_VICMD_SYMBOL="ν"

zplugin light zdharma/zui
zplugin light zdharma/zplugin-crasis

export MANPAGER="nvim -c 'set ft=man' -"

# direnv stuff
eval "$(direnv hook zsh)"

# my aliases
alias ll='exa -l'
alias ls='exa'
alias llt='exa -T'
alias llfu='exa -bghHliS --git'
alias prev='fzf --preview "bat --color always {}"'
alias g='hub'
alias git='hub'
alias pp='prettyping'
