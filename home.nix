{ config, pkgs, ... }:

{

  home.packages = with pkgs; [

    # cli utils
    stow
    ranger
    fd
    nnn
    ripgrep
    exa
    gtypist
    rclone
    trash-cli
    age
    gitAndTools.diff-so-fancy
    prettyping
    jq
    magic-wormhole
    unrar
    pdftk

    # (texlive.combine {
    #   inherit (texlive)
    #      collection-basic
    #      collection-bibtexextra
    #      collection-binextra
    #      collection-xetex
    #      collection-luatex
    #      collection-latexrecommended
    #      collection-latexextra
    #      collection-langenglish
    #      collection-latex;
    #   })
  ];

  programs.zathura = {
    enable = true;
  };

  programs.beets = {
    enable = true;
    settings = {
      directory = "~/music";
      library = "~/music/beets/musiclibrary.db";
    };
  };

  programs.htop.enable = true;

  programs.direnv.enable = true;

  programs.bat.enable = true;

  programs.tmux = {
    enable = true;
  };

  # password management
  programs.password-store = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile neovim/init.vim;
  };


  # programs.git = {
  #   package = pkgs.gitAndTools.gitFull;
  #   enable = true;
  #   userName = "Patrick Elliott";
  #   userEmail = "patrick.d.elliott@gmail.com";
  #   signing = {
  #     signByDefault = true;
  #     key = "1B5E5824F4429D036C8A17517CA109C3974AF5FA";
  #   };
  # };

  services.gpg-agent = {
    enable = true;
    enableSshSupport= true;
    pinentryFlavor = "gnome3";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "19.09";

}
