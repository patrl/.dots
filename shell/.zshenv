export npm_config_prefix=~/.node_modules
path+=('/home/patrl/.local/bin')
path+=('/home/patrl/.emacs.d/bin')
path+=('/home/patrl/.node_modules/bin')
path+=('/home/patrl/.cargo/bin')
path+=('/home/patrl/.zplugin/plugins/junegunn---fzf-bin')
export MANPAGER="nvim -c 'set ft=man' -"
export EDITOR="emacsclient -c"
# alias steam='GDK_SCALE=2 steam'
ZDOTDIR=$HOME/.config/zsh

# nnn stuff
export NNN_TRASH=1 # nnn trashes files to the desktop Trash
export NNN_TMPFILE="/tmp/nnn"
export NNN_USE_EDITOR=1
export NNN_OPENER=mimeopen

n()
{
        nnn "$@"

        if [ -f $NNN_TMPFILE ]; then
                . $NNN_TMPFILE
                rm $NNN_TMPFILE
        fi
}

export MOZ_ENABLE_WAYLAND=1 # enable wayland support in firefox
