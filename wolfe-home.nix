{ config, pkgs, ... }:

let
  # latest firefox
  mozilla-overlay = fetchTarball {
      url = https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
  };
  # latest emacs
  emacs-overlay = fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    };
in {

  imports = [
    ./programs/tex/tex.nix # latex stuff
    ./common.nix # stuff I want on every machine
  ];
  ###########
  # general #
  ###########

  home.sessionVariables = {
    # use emacs as my default editor
    EDITOR = "${config.programs.emacs.package}/bin/emacsclient -c";
    VISUAL = "${config.programs.emacs.package}/bin/emacsclient -c";
    MAILDIR = "$HOME/.mail";
    LEDGER_FILE="$HOME/finance/all-years.journal";
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
    ".config/nvim/init.vim" = {
      source = programs/neovim/init.vim;
    };
    ".agda/defaults" = {
      source = programs/agda/defaults;
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
    ".local/share/applications/emacs-client.desktop" = {
      source = programs/mimeapps/emacs-client.desktop;
    };
    ".local/share/applications/org-protocol.desktop" = {
      source = programs/mimeapps/org-protocol.desktop;
    };
  };

  nixpkgs.overlays = [

  (self: super: {
     neovim = super.neovim.override {
       viAlias = true;
       vimAlias = true;
     };
   })

    (self: super: {
      weechat = super.weechat.override {
        configure = { ... }: {
          scripts = with self.weechatScripts; [
            wee-slack
            weechat-matrix
          ];
        };
      };
    })

    # adds support for nerd font icons to nnn
    (self: super: {
      nnn = super.nnn.override {
        withNerdIcons = true;
      };
    })


    # (import ./overlays/lieer.nix )
    # (import ./overlays/git-latexdiff.nix )
    (import ./overlays/exult.nix )
    (import ./overlays/twad.nix )
    (import ./overlays/brogueCE.nix )
    (import ./overlays/pico-8.nix )
    (import ./overlays/slade.nix ) # FIXME
    (import "${mozilla-overlay}")
    (import "${emacs-overlay}")
    # (import ./overlays/zotero.nix) # TODO this is only necessary temporarily
    ];

    # nixpkgs.config = {
    #   retroarch = {
    #     enableSnes9x = true;
    #     enableBeetlePSX = true;
    #     enableBeetlePCEFast = true;
    #     enableDolphin = true;
    #   };
    # };




  ##################################
  # password and secret management #
  ##################################

  programs.gpg.enable = true;

  home.packages = with pkgs; [

    #############
    # cli tools #
    #############

    # steam-run-native # FIXME gstreamer error
    ffmpeg # video conversion and manipulation
    du-dust # rust utility to view disk space
    youtube-dl # cli to download audio/video from youtube
    sqlite # emacs seems to require the sqlite3 binary these days
    niv # dependency management for nix
    powertop # change power management settings
    glxinfo # graphics settings
    feh # simple image viewer
    maim # screenshot tool
    xorg.xprop # utility for X info
    vulkan-tools # vulkan tools
    rmapi # remarkable
    # git-latexdiff
    docker
    borgbackup
    gnumake # provides make
    inotify-tools # provides filewatch
    qrencode # encode as a QR code
    paperkey # backup gpg key
    entr

    ############
    # gui apps #
    ############

    # tor-browser-bundle-bin # FIXME totally anonymous web browsing
    transmission-gtk # torrenting
    dropbox # cloud file storage
    spotify # muzak
    vscode # slick editor
    discord # chat
    zoom-us # zoom
    slack # slack
    zotero # bibliography management
    rofi-pass # pass ui
    rofi-systemd # systemd ui
    pavucontrol # audio settings
    polybar # status bar
    zotero # bibliography management
    zulip # foss slack
    krita # image editing
    gparted # partition editing
    peek # screen cast
    aseprite # sprite editing
    rx # minimalist pixel art editor
    tiled # map editor
    xournalpp # pdf editor

    hledger
    hledger-ui
    hledger-web
    # haskellPackages.hledger-flow # FIXME

    xchm

    #############
    # languages #
    #############

    # N.b. I mostly just use ad-hoc nix-shells

    lua5_4
    poetry # manage python dependencies (I'm using this with poetry2nix)
    # (agda.withPackages [ agdaPackages.standard-library ]) # FIXME
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
    lmodern # stops lualatex from throwing bugs



    #########
    # games #
    #########

    pcsx2
    twad
    vkquake
    slade
    crispyDoom
    gzdoom
    retroarchBare
    # brogue
    (pkgs.steam.override { extraPkgs = pkgs: [ pipewire.lib ]; })
    brogue-ce
    exult16
    steam-run-native
    (pkgs.dwarf-fortress-packages.dwarf-fortress-full.override {
     theme = "meph";
    })
    pico-8




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
    enable = false;
    settings  = {
      directory = "/home/patrl/keybase/private/patrl/music";
      library = "/home/patrl/keybase/private/patrl/music/beets/musiclibrary.db";
    };
  }; # FIXME todo get library and directory settings working properly, pointing at keybase



  ##############
  # appearance #
  ##############

  services.gammastep = {
    enable = true;
    tray = true;
    provider = "manual";
    latitude = "42.4";
    longitude = "71.1";
    settings = {
      general = {
        brightness = 0.5;
      };
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
    package = pkgs.latest.firefox-beta-bin;
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
