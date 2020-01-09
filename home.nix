{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    stow
    htop

    (texlive.combine {
      inherit (texlive)
         collection-basic
         collection-bibtexextra
         collection-binextra
         collection-xetex
         collection-luatex
         collection-latexrecommended
         collection-latexextra
         collection-langenglish
         collection-latex;
      })
  ];

programs.password-store = {
  enable = true;
};

programs.neovim = {
  enable = true;
  extraConfig = builtins.readFile neovim/init.vim;
};

programs.git = {
  package = pkgs.gitAndTools.gitFull;
  enable = true;
  userName = "Patrick Elliott";
  userEmail = "patrick.d.elliott@gmail.com";
  signing = {
    signByDefault = true;
    key = "1B5E5824F4429D036C8A17517CA109C3974AF5FA";
  };
};

services.gpg-agent = {
  enable = true;
};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";
}
