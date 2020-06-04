{ config, pkgs, ... }:

let
  mozilla-overlay = fetchTarball {
      url = https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
  };
  emacs-overlay = fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    };
in {

  imports = [
    ./tex.nix # latex stuff
    ./common.nix
  ];
  ###########
  # general #
  ###########

  home.sessionVariables = {
    # use emacs as my default editor
    EDITOR = "${config.programs.emacs.package}/bin/emacsclient -c";
    VISUAL = "${config.programs.emacs.package}/bin/emacsclient -c";
    MAILDIR = "$HOME/.mail";
  };

  home.file = {
    ".config/alacritty/alacritty.yml" = {
      source = programs/alacritty/alacritty.yml;
    };
    ".config/sxhkd/sxhkdrc" = {
      source = programs/sxhkd/sxhkdrc;
    };
    ".config/polybar/launch.sh" = {
      source = programs/polybar/launch.sh;
      executable = true;
    };
    ".config/polybar/config" = {
      source = programs/polybar/polybar.conf;
    };
    ".mbsyncrc" = {
      source = programs/isync/mbsync.conf;
    };
    ".local/share/applications/mimeapps.list" = {
      source = programs/mimeapps/mimeapps.list;
    };
    ".local/share/applications/emacs-dired.desktop" = {
      source = programs/mimeapps/emacs-dired.desktop;
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      weechat = super.weechat.override {
        configure = { ... }: {
          scripts = with self.weechatScripts; [
            wee-slack
          ];
        };
      };
    })

    (import ./overlays/lieer.nix )
    (import ./overlays/exult.nix )
    (import "${mozilla-overlay}")
    (import "${emacs-overlay}")
    ];

    nixpkgs.config = {
      retroarch = {
        enableSnes9x = true;
        enablePCSXRearmed = true;
        enableBeetlePSX = true;
      };
    };




  ##################################
  # password and secret management #
  ##################################

  programs.gpg.enable = true;

  home.packages = with pkgs; [

    #############
    # cli tools #
    #############

    niv
    powertop # change power management settings
    glxinfo # graphics settings
    feh
    maim # screenshot tool
    xorg.xprop
    vulkan-tools

    ############
    # gui apps #
    ############

    dropbox # cloud service
    spotify # muzak
    vscode # burn the witch
    discord
    zoom-us
    slack
    zotero
    rofi-pass
    rofi-systemd
    pavucontrol
    polybar
    zotero
    zulip
    calibre
    krita
    gparted
    peek
    aseprite
    rx
    tiled

    #############
    # languages #
    #############

    # N.b. I mostly just use ad-hoc nix-shells

    poetry # manage python dependencies (I'm using this with poetry2nix)
    (agda.withPackages [ agdaPackages.standard-library ])
    coq # coq
    # idris # FIXME
    rustup # rust
    racket # racket
    nodejs # js
    # haskellPackages.Agda # FIXME there's an agda rework attempt happening here: https://github.com/NixOS/nixpkgs/pull/76653


    #########
    # fonts #
    #########

    cascadia-code



    #########
    # games #
    #########

    retroarch
    brogue
    steam
    exult16




    gsettings-desktop-schemas # maybe necessary for zotero

  ];



  ###########
  # editors #
  ###########

  programs.emacs = {
    package = pkgs.emacsUnstable;
  };

  services.emacs.enable = true;




  #################
  # shell and cli #
  #################
 
  # avoid derangement via direnv
  # programs.direnv = {
  #   enable = true;
  #   # stdlib = builtins.readFile programs/direnv/direnvrc;
  # };
  #

  programs.beets = {
    enable = true;
    settings  = {
      directory = "/home/patrl/keybase/private/patrl/music";
      library = "/home/patrl/keybase/private/patrl/music/beets/musiclibrary.db";
    };
  }; # todo get library and directory settings working properly, pointing at keybase



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
    imageDirectory = "%h/.dots/programs/bg";
  };

  # gtk config
  gtk = ( import programs/gtk/default.nix {inherit pkgs;});

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

  programs.firefox = {
    enable = true;
    package = pkgs.latest.firefox-nightly-bin;
  };

  programs.chromium.enable = true;

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
