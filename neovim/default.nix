{ pkgs, ... }:

let
  plugins = pkgs.vimPlugins // pkgs.callPackage ./custom-plugins.nix {};
in {
  enable = true;
  viAlias = true;
  vimAlias = true;
  configure = {
    customRC = builtins.readFile ./init.vim;
    plug.plugins = with plugins; [
      # theme
      nnn
      vim-sensible # no need to configure this
      vim-easy-align
      vim-slash
      vim-devicons
      vim-startify
      vim-nix
      ultisnips
      vim-snippets
      vim-fugitive
      vim-surround
      nerdtree
      vim-commentary
      goyo
      fzfWrapper
      fzf-vim
      vim # this is the (incorrectly named!) dracula theme
      coc-nvim
      vimtex
      coc-vimtex
    ];
  };
}
