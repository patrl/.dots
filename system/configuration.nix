{ config,  pkgs, ... }:

let
  stable = import <nixos-stable> { config = { allowUnfree = true;  }; };
in {
  imports =
  [ # Include the results of the hardware scan.
    ./gnome.nix
    ./xorg.nix
    ./hardware-breq.nix
    ./wayland.nix
    ./compton.nix
    ./bspwm.nix
    # ./mopidy.nix
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
    # ./redshift.nix
    ./steam.nix
    ./wine.nix
    ./multi-glibc-locale-paths.nix
    ./yubikey.nix
  ];

  powerManagement.powertop.enable = true; # power saving

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
      # plymouth.enable = true; # makes the boot screen a little bit nicer. Completely pointless.
      extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ]; # exfat support
  };

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
  time.timeZone = "America/New_York";

  # Pulse
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true; # need this for steam
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };

  # bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # brightness support
  hardware.brightnessctl.enable = true;

  # necessary for steam
  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = with pkgs; [

    rustup # rust
    racket # racket
    carnix
    sbcl # common lisp
    leiningen # clojure
    coq # coq
    idris # idris

    # terminal emulator (wayland)
    termite

    # build tools
    gcc
    gnumake

    # media
    mpv
    feh

    # audio
    audacity
    spotify
    pamix

    # pdf
    evince
    zathura
    xournal # for signing and annotations


    # chat
    discord

    # applets
    blueman # necessary with a WM
    networkmanagerapplet
    udiskie
    # python27Packages.websocket_client
    # unstable.neofetch

    # torrent
    (pkgs.transmission.override { enableGTK3 = true; })

    solaar

    alacritty

    # misc
    acpilight # needed for backlight
    # gtk3-x11
    # unstable.w3m
    inotify-tools
    binutils
    file
    snapper
    hdparm

    # management tool
    zotero

    libreoffice

    # launcher
    dmenu
    rofi-pass
    rofi

    # appearance
    lxappearance
    lxappearance-gtk3
    vanilla-dmz

    # browsers
    # unstable.google-chrome
    # n.b. I install firefox nightly from the mozilla overlays
    chromium

    # games
    # retroarch
    brogue
    cataclysm-dda
    sil
    # unstable.love_11

    # file manager
    ranger
    libcaca

    # dependencies for `capture:`
    slop
    ffmpeg

    # cli tools
    bat # cat clone
    fd # find clone
    ripgrep # grep clone
    exa # ls clone
    # unstable.fzf # fuzzy finding
    stow # manage sym-links
    tmux # multiplexer
    htop # process monitor
    scrot # screenshots
    gtkpod

    # archive management
    zip
    unzip
    p7zip

    # version control
    subversion
    gitAndTools.hub
    gitAndTools.gitFull
    gitAndTools.git-annex
    lsof
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
    pinentry-curses

    imagemagick
    gtypist
    wget
    libqrencode
    zbar
    rclone
    trash-cli
    direnv
    perl528Packages.FileMimeInfo

    # file manager
    nnn
    # unstable.ranger
  ];

  # environment.etc = {
  #   "gtk-2.0/gtkrc".text = ''
  #     gtk-cursor-theme-name = Vanilla-DMZ
  #     gtk-cursor-theme-size = 48
  #   '';
  #   "gtk3.0/settings.ini".text = ''
  #     gtk-cursor-theme-name = Vanilla-DMZ
  #     gtk-cursor-theme-size = 48
  #   '';
  # };
  #
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.ssh.startAgent = false;


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.openssh.permitRootLogin = "yes";

  programs.ssh.askPassword = "";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.patrl = {
    description = "Patrick Elliott";
    createHome = true;
    # note that I need to be in the audio group for mopidy
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
    isNormalUser = true;
    uid = 1000;
  };

  security.sudo.wheelNeedsPassword = false;

  hardware.cpu.intel.updateMicrocode = true;

  services.udev.packages = with pkgs; [ logitech-udev-rules ];

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
      # japanese
      ipafont
      kochi-substitute
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; {
    haskellPackages = haskellPackages.override {
    overrides = self: super: {
    sdl2 = pkgs.haskell.lib.dontCheck super.sdl2;
    };
    };
  };
  };

  nix = {
   package = pkgs.nixUnstable;
   autoOptimiseStore = true;
   binaryCaches = [
     "https://cache.nixos.org/"
     "https://nixcache.reflex-frp.org" # binary cache for reflex-platform
     "https://hie-nix.cachix.org"
     "https://nixpkgs-wayland.cachix.org"
   ];
    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
    trustedUsers =[ "root" "patrl" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

  services.upower.enable = true;

  # services.snapper.configs = {
  #   "home" = {
  #     subvolume = "/home";
  #     extraConfig = ''
  #       ALLOW_USERS="patrl"
  #       TIMELINE_CREATE="yes"
  #     '';
  #   };
  # };

  # services.snapper.cleanupInterval = "1d";
  # services.snapper.snapshotInterval = "hourly";

}
