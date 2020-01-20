{ pkgs, ... }:

let
  plugins = pkgs.vimPlugins;
in {
  enable = true;
  viAlias = true;
  vimAlias = true;
  configure = {
    customRC = builtins.readFile ./init.vim;
    plug.plugins = with plugins; [
      # theme
      vim-sensible
      vim-easy-align
      vim-slash
      vim-devicons
      vim-startify
      vim-nix
      supertab
      ultisnips
      vim-snippets
      vim-fugitive
      vim-surround
      nerdtree
      vim-commentary
      goyo
      fzfWrapper
      fzf-vim
      vim
    ];
  };
}
