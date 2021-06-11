{ config, pkgs, ... }:

{

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  }; # software doesn't grow on tree


  home.sessionVariables = {
    # use emacs as my default editor
    EDITOR = "${pkgs.neovim}/bin/nvim";
    # read man pages in neovim (hot!)
    MANPAGER = "${pkgs.neovim}/bin/nvim -c 'set ft=man' -";
    WEECHAT_HOME = ''${config.xdg.configHome}/weechat'';
  };

  home.packages = with pkgs; [

    ###############
    # build tools #
    ###############
    gcc





    #############
    # nix tools #
    #############

    nix-prefetch-git # update hash in a nix expression; best used through emacs
    # nixfmt




    #############
    # cli tools #
    #############

    neovim
    stow # symlink manager
    gh # official github cli. I alias git to this.
    gitAndTools.git-ignore # auto fetch language template
    exa # improved ls in rust
    ripgrep # grep with batteries
    prettyping # prettier ping
    age # pgp, but good
    weechat # irc client
    trash-cli # for the rm-happy among us; used by nnn
    nnn # file manager
    unzip # unzipping
    zip
    aspell
    aspellDicts.en # cli spellcheck; used by emacs
    gtypist
    rclone
    rsync
    # ssb-patchwork # FIXME
    bc # cli calc
    figlet
    neofetch
    file # need this for the nnn plugin nuke
    fd # supercharged find
    cmus # cli audio player
    pandoc
    # haskellPackages.pandoc-citeproc # FIXME
    pdftk
    graphviz
    imagemagick



    ########
    # mail #
    ########

    isync
    mu


  ];

  ##################################
  # password and secret management #
  ##################################

  programs.password-store = {
    package = pkgs.pass.withExtensions (exts: [ exts.pass-audit ]);
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "/home/patrl/.password-store";
      PASSWORD_STORE_KEY = "patrick.d.elliott@gmail.com";
    };
  };



  ###########
  # editors #
  ###########

  # programs.neovim = ( import programs/neovim/default.nix { inherit pkgs; });

  programs.emacs.enable = true;




  #################
  # shell and cli #
  #################

  programs.git = ( import programs/git/default.nix { inherit pkgs; }); # git gud

  programs.bat.enable = true; # a purrfect replacement for cat

  services.lorri.enable = true;

  programs.direnv.enable = true;

  # junegunn's fuzzy finder
  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f --hidden --follow --exclude .git --exclude .cache/";
    fileWidgetCommand = "${config.programs.fzf.defaultCommand}";
    defaultOptions = [
      "--color=bg+:#44475a,bg:#282a36,spinner:#50fa7b,hl:#44475a"
      "--color=fg:#f8f8f2,header:#ff5555,info:#ff5555,pointer:#50fa7b"
      "--color=marker:#ff5555,fg+:#f8f8f2,prompt:#50fa7b,hl+:#44475a"
    ];
  };

  programs.htop.enable = true; # check whether your laptop is melting

  # a spicy hot file manager
  programs.broot.enable = true;

  # ze best shell
  programs.zsh = ( import programs/zsh/default.nix { inherit pkgs; });

  programs.starship.enable = true;

  programs.starship.settings = {
    character.success_symbol = "λ";
    add_newline = "false";
  };



  ##################################
  # password and secret management #
  ##################################

  programs.browserpass = {
    enable = true;
    browsers = [ "firefox" ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "gtk2";
  };

}
