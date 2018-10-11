{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true;  }; };
in {
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-breq.nix
    ./compton.nix
    ./bspwm.nix
    # ./mopidy.nix
    # ./xmonad.nix
    ./st.nix
    ./zsh.nix
    ./fish.nix
    ./keybase.nix
    ./tex.nix
    ./weechat.nix
    ./emacs.nix
    ./nvim.nix
    ./haskell.nix
    # ./rust.nix
    ./redshift.nix
    ./steam.nix
    ./syncthing.nix
    # ./wireguard.nix
    # ./wine.nix
    ./multi-glibc-locale-paths.nix
  ];


  powerManagement.powertop.enable = true;

  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.enable = false;};
    plymouth.enable = true;};

  networking = {
    hostName = "breq";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    # This makes the font readable on a high dpi screen. Note that this is dependent on having installed terminus_font.
    consoleFont = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Pulse with additional support for jack
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull.override { jackaudioSupport = true; };
    support32Bit = true;
  };

  # bluetooth support
  hardware.bluetooth.enable = true;

  # necessary for steam
  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = with pkgs; [

    # dev
    unstable.rustup
    unstable.racket
    unstable.carnix
    unstable.sbcl # common lisp
    unstable.leiningen # clojure
    unstable.nodejs-8_x # js
    unstable.nodePackages.node2nix
    unstable.coq # coq
    unstable.idris # agda

    # build tools
    gcc
    gnumake

    # media
    unstable.spotify
    mpv
    pavucontrol
    jack2Full
    qjackctl
    audacity
    unstable.supercollider
    pamix
    feh
    gnome3.gnome-screenshot

    # pdf
    evince
    zathura

    # webcam
    guvcview

    # terminal
    unstable.alacritty

    # chat
    unstable.discord

    # applets
    blueman
    networkmanagerapplet
    udiskie
    python27Packages.websocket_client
    unstable.neofetch

    # torrent
    (pkgs.transmission.override { enableGTK3 = true; })

    # misc
    gtk3-x11
    gnome3.dconf
    xlibs.xbacklight
    unstable.w3m
    inotify-tools
    binutils
    file
    dropbox

    # management tool
    unstable.calibre
    unstable.zotero

    # launcher
    dmenu
    # unstable.rofi-pass
    # unstable.rofi
    rofi-pass
    rofi

    # appearance
    lxappearance
    lxappearance-gtk3
    vanilla-dmz

    # browsers
    unstable.google-chrome
    tor-browser-bundle-bin
    # n.b. I install firefox nightly from the mozilla overlays

    # games
    retroarch
    brogue
    (unstable.pkgs.dwarf-fortress-packages.dwarf-fortress-full.override {
      theme = "gemset";
      enableIntro = false;
    })
    unstable.crispyDoom
    unstable.love_11

    # file manager
    xfce.thunar
    ranger
    libcaca

    # dependencies for `capture:`
    slop
    ffmpeg

    # cli tools
    unstable.bat # cat clone
    unstable.fd # find clone
    unstable.ripgrep # grep clone
    unstable.exa # ls clone
    # unstable.fzf # fuzzy finding
    stow # manage sym-links
    tmux # multiplexer
    htop # process monitor
    scrot # screenshots

    # archive management
    zip
    unzip
    p7zip

    nodePackages.dat

    # version control
    subversion
    gitAndTools.hub
    gitAndTools.gitFull
    gitAndTools.git-annex
    gist

    # password management
    pass
    pass-otp

    # nix tools
    nix-prefetch-git

    bind
    xorg.xdpyinfo
    apulse
    btrfs-progs
    scrot
    krita
    gnupg

    imagemagick
    gtypist
    wget

    zeal

  ];

  environment.etc = {
    "gtk-2.0/gtkrc".text = ''
      gtk-cursor-theme-name = Vanilla-DMZ
      gtk-cursor-theme-size = 48
    '';
    "gtk3.0/settings.ini".text = ''
      gtk-cursor-theme-name = Vanilla-DMZ
      gtk-cursor-theme-size = 48
    '';
    "geoclue/geoclue.conf".text = ''
      [redshift]
      allowed=true
      system=false
      users=
    '';
  };

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.openssh.permitRootLogin = "yes";

  programs.ssh.askPassword = "";

  services.xserver = {
    enable = true;
    config = ''
      Section "Monitor"
        Identifier  "<default monitor>"
        DisplaySize 293 165
      EndSection
      '';
    layout = "gb";
    xkbOptions = "eurosign:4";
    libinput.enable = true;
    displayManager = {
      slim.enable = true;
      slim.defaultUser = "patrl";
      sessionCommands = ''
        xrdb -merge /etc/X11/Xresources
        xsetroot -xcf ${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ/cursors/X_cursor 48
        ${pkgs.networkmanagerapplet}/bin/nm-applet &
        NIX_SKIP_KEYBASE_CHECKS=1 /run/current-system/sw/bin/keybase-gui &
        ${pkgs.udiskie}/bin/udiskie --s &
        ${pkgs.feh}/bin/feh --bg-max --randomize /home/patrl/Sync/Wallpapers/rotation/* &
        ${pkgs.dropbox}/bin/dropbox &
      '';
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.patrl = {
    description = "Patrick Elliott";
    createHome = true;
    extraGroups = [ "wheel" "networkmanager" ];
    isNormalUser = true;
    uid = 1000;
  };

  security.sudo.wheelNeedsPassword = false;

  hardware.cpu.intel.updateMicrocode = true;

  fonts = {
    fontconfig.penultimate.enable = true;
    fontconfig.dpi = 192;
    enableFontDir = true;
    fonts = with pkgs; [
      terminus_font
      source-code-pro
      hack-font
      gohufont
      monoid
      hasklig
      libertine
      liberation_ttf
      fira-code
      fira
      fira-mono
      iosevka
      inconsolata
      font-awesome_5
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };


  nix = {
   package = pkgs.nixUnstable;
   autoOptimiseStore = true;
   binaryCaches = [
     "https://cache.nixos.org/"
     # binary cache for reflex-platform
     "https://nixcache.reflex-frp.org"
     "https://hie-nix.cachix.org"
   ];
    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
    ];
    trustedUsers =[ "root" "patrl" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

  services.nixosManual = {
    enable = true;
    showManual = true;
    ttyNumber = 8;
  };

  services.upower.enable = true;

  # services.xserver.windowManager.bspwm.enable = true;

  # services.xserver.windowManager.default = "bspwm";


}
