# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in {
  imports =
    [ # Include the results of the hardware scan.
      ./wolfe-hardware.nix
    ];

  ###########
  # general #
  ###########

  nixpkgs.config.allowUnfree = true;

  # the following is currently needed for cachix on nixos
  nix.trustedUsers = [ "root" "patrl" ];

  # nix.package = pkgs.nixFlakes; # FIXME I need this in order to play around with the experimental flakes branch




  ###########################
  # hardware specific fixes #
  ###########################

  powerManagement = {
    enable = true;
    powertop.enable = true;
  }; # this is the default setting

  services.upower.enable = true; # this is necessary for the system to automatically suspend when the battery is low
  systemd.services.upower.enable = true;

  hardware = {
    enableAllFirmware = true; # generally a good idea on newer hardware
    cpu.intel.updateMicrocode = true;
    steam-hardware.enable = true;
    # recognise trackpoint on thinkpad x1 extreme gen 2
    trackpoint.device = "TPPS/2 Elan TrackPoint";
    # support for logitech mx ergo
    # logitech.wireless = {
      # enable = true;
      # enableGraphical = true; # TODO this installs solaar, which doesn't currently work
    # };
  };



  # fixes a bug with battery reporting (see: https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Extreme_(Gen_2))
  boot.initrd.availableKernelModules = [ "battery" ];

  boot.kernelPackages = pkgs.linuxPackages_latest; # the latest kernel is necessary for the wifi to work

  # fixes intel cpu throttling
  services.throttled.enable = true;




  #############
  # bluetooth #
  #############

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    package = pkgs.bluezFull;
  };

  services.blueman.enable = true;




  #########
  # audio #
  #########

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true; # need this for steam
  };

  hardware.opengl = {
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };




  ##########
  # nvidia #
  ##########

  boot.blacklistedKernelModules = [ "nouveau" ]; # blacklist the opensource nvidia driver. This will lead to kernel panics

  hardware.nvidia = {
    prime = {
      offload.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
    modesetting.enable = true;
  };

  # services.xserver.videoDrivers = [ "intel" ];
  services.xserver.videoDrivers = [ "nvidia" ];




  ###############
  # boot loader #
  ###############

  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max";
    editor = false;
  };

  boot.loader.efi.canTouchEfiVariables = true;




  #######
  # zfs #
  #######

  boot.supportedFilesystems = [ "zfs" ];

  boot.zfs = {
    enableUnstable = true;
    requestEncryptionCredentials = true;
  };

  services.zfs = {
    trim.enable = true; # good for ssds!
    autoScrub.enable = true;
    autoSnapshot = {
      enable = true;
      frequent = 4; # keep the latest eight 15-minute snapshots (instead of four)
      hourly = 12;
      daily = 7;
      weekly = 4;
      monthly = 1;  # keep only one monthly snapshot (instead of twelve)
    };
  };






  #########
  # fonts #
  #########

  # declare some sensible default fonts
  fonts = {
    fontconfig.dpi = 192;
    fonts = with pkgs; [
      ibm-plex
    ];
    fontconfig.defaultFonts = {
      monospace = [ "IBM Plex Mono" "DejaVu Sans Mono" ];
      sansSerif = [ "IBM Plex Sans" "DejaVu Sans"];
      serif = [ "IBM Plex Serif" "DejaVu Serif"];
    };
  };




  ########
  # xorg #
  ########

  services.xserver = {
    # correctly set the display dimensions for the thinkpad x1 extreme gen 2
    monitorSection =  ''
      DisplaySize 344 193
      '';
    displayManager.lightdm = {
      enable = true;
      greeters.mini = {
        enable = true;
        user = "patrl";
        extraConfig = (builtins.readFile programs/mini-greeter/mini-greeter.conf);
      };
    };
    displayManager.defaultSession = "none+bspwm";
    # the set line makes the screen turn off in 60, sleep in 360, and hibernate in 800.
    displayManager.sessionCommands = ''
     light-locker --lock-on-suspend --lock-on-lid --lock-after-screensaver=0 &

     xset dpms 60 360 800 &
     '';
    desktopManager.xterm.enable = false;
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    libinput = {
      enable = true;
      touchpad.accelSpeed= "0.5"; # the trackpad by default is way too insensitive
    };
    windowManager.bspwm = {
      enable = true;
      configFile = programs/bspwm/bspwmrc;
    };
  };

  services.picom = {
    enable = true;
    shadow = true;
    backend = "glx";
    inactiveOpacity = 0.8;
    shadowExclude = [ "class_g = 'Firefox' && argb" ];
  };

  environment.sessionVariables = {
    NNN_OPTS = "eE";
    NNN_TRASH= "1"; # nnn trashes files to the desktop Trash
    NNN_TMPFILE = "/tmp/nnn";
    NNN_USE_EDITOR= "1";

    PURE_PROMPT_SYMBOL="λ";
    PURE_PROMPT_VICMD_SYMBOL="ν";

    QT_SCALE_FACTOR= "2"; # this is primarily to get zoom scaling properly
  };

  environment.etc = {
    "gtk-2.0/gtkrc".text = ''
      gtk-cursor-theme-name = Vanilla-DMZ
      gtk-cursor-theme-size = 48
    '';
    "gtk3.0/settings.ini".text = ''
      gtk-cursor-theme-name = Vanilla-DMZ
      gtk-cursor-theme-size = 48
    '';
  };

  services.dbus.packages = with pkgs; [ gnome3.dconf ];




  ##############
  # networking #
  ##############

  networking = {
    networkmanager.enable = true;
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = true; # wired connection
      wlp82s0.useDHCP = true; # wireless connection
    };
    hostName = "wolfe";
    hostId = "8cea25c4";
    firewall.enable = true;
  };

  services.openssh.enable = true;
  programs.mosh.enable = true;




  ########################
  # internationalisation #
  ########################

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz"; # readable on high dpi displays
    keyMap = "us";
  };

  time.timeZone = "America/New_York";




  ############
  # packages #
  ############

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    nvidia-offload

    wget
    vim
    git
    keybase-gui
    vanilla-dmz
    hicolor-icon-theme
    lightlocker
  ];

  services.keybase.enable = true;
  services.kbfs.enable = true;




  ##############
  # user space #
  ##############

  users.extraUsers.patrl = {
    description = "Patrick Elliott";
    createHome = true;
    # note that I need to be in the audio group for mopidy
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    isNormalUser = true;
    uid = 1000;
  };

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;

  programs.ssh.askPassword = "";


  ##################
  # virtualization #
  ##################

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  ####################
  # DON'T TOUCH THIS #
  ####################

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}
