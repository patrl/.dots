{ config, pkgs, ... }:

{

  imports = [ ./tex.nix ]; # latex stuff

  ###########
  # general #
  ###########

  home.sessionVariables = {
    # use emacs as my default editor
    EDITOR = "${config.programs.emacs.package}/bin/emacsclient -c";
    # read man pages in neovim (hot!)
    MANPAGER = "${config.programs.neovim.package}/bin/nvim -c 'set ft=man' -";
  };

  home.file = {
    ".config/alacritty/alacritty.yml" = {
      source = alacritty/alacritty.yml;
    };
    ".config/sxhkd/sxhkdrc" = {
      source = sxhkd/sxhkdrc;
    };
    ".config/polybar/launch.sh" = {
      source = polybar/launch.sh;
    };
    ".config/polybar/config" = {
      source = polybar/polybar.conf;
    };
    ".local/share/applications/mimeapps.list" = {
      source = mimeapps/mimeapps.list;
    };
    ".local/share/applications/emacs-dired.desktop" = {
      source = mimeapps/emacs-dired.desktop;
    };
  };

  nixpkgs.config.allowUnfree = true; # software doesn't grow on trees




  ##################################
  # password and secret management #
  ##################################

  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "/home/patrl/.password-store";
      PASSWORD_STORE_KEY = "patrick.d.elliott@gmail.com";
    };
  };

  programs.browserpass = {
    enable = true;
    browsers = [ "firefox" ];
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
  };

  home.packages = with pkgs; [




    #############
    # nix tools #
    #############

    nix-prefetch-git # update hash in a nix expression; best used through emacs




    #############
    # cli tools #
    #############

    stow # symlink manager
    gitAndTools.hub # github cli (official). I alias git to this.
    exa # improved ls in rust
    ripgrep # grep with batteries
    prettyping # prettier ping
    age # pgp, but good
    weechat # irc client
    trash-cli # for the rm-happy among us; used by nnn
    nnn # file manager
    unzip # unzipping
    ispell # cli spellcheck; used by emacs
    powertop # change power management settings
    glxinfo # graphics settings
    gtypist
    rclone
    rsync
    magic-wormhole
    ssb-patchwork
    bc # cli calc
    figlet
    neofetch
    feh
    maim
    xorg.xprop




    ############
    # gui apps #
    ############

    dropbox # cloud service
    spotify # muzak
    vscode # burn the witch
    discord
    zotero
    rofi-pass
    rofi-systemd
    pavucontrol
    polybar




    #############
    # languages #
    #############

    haskellPackages.Agda # useless but cool
    coq # coq
    idris # idris
    rustup # rust
    racket # racket



    #########
    # fonts #
    #########

    cascadia-code

  ];



  ###########
  # editors #
  ###########

  programs.emacs.enable = true;

  programs.neovim = ( import neovim/default.nix { inherit pkgs; });

  services.emacs.enable = true;




  #################
  # shell and cli #
  #################

  programs.bat.enable = true; # a purrfect replacement for cat

  programs.git = ( import git/default.nix { inherit pkgs; }); # git gud

  # avoid derangement via direnv
  programs.direnv = {
    enable = true;
    stdlib = builtins.readFile direnv/direnvrc;
  };

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

  # ze best shell
  programs.zsh = ( import zsh/default.nix { inherit pkgs; });

  programs.htop.enable = true; # check whether your laptop is melting

  # a spicy hot file manager
  programs.broot.enable = true;




  ##############
  # appearance #
  ##############
  services.redshift = {
    enable = true;
    provider = "manual";
    latitude = "42.4";
    longitude = "71.1";
    tray = true;
    brightness = {
      day = "0.5";
      night = "0.5";
    };
  };

  fonts.fontconfig.enable = true;

  # wallpaper service (uses feh)
  services.random-background = {
    enable = true;
    enableXinerama = true;
    imageDirectory = "%h/.dots/bg";
  };

  # gtk config
  gtk = ( import gtk/default.nix {inherit pkgs;});

  # ensures a reasonably sized cursor
  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
  };




  ############
  # gui apps #
  ############

  programs.mpv.enable = true;

  programs.zathura.enable = true; # the one true pdf reader

  services.network-manager-applet.enable = true;

  services.udiskie.enable = true;

  # a might fine dmenu replacement
  programs.rofi = {
    enable = true;
    theme = "sidebar";
    font = "IBM Plex Sans 36";
    # fullscreen = true;
  };

  # super fast terminal
  programs.alacritty.enable = true;

  programs.firefox.enable = true;

  systemd.user.services.dropbox = {
    Unit = {
      Description = "Dropbox";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    sessionVariables = {
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    };
    Service = {
      ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
      ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
  };





  ########################
  # DON'T MESS WITH THIS #
  ########################

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
