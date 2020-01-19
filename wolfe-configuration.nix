# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./wolfe-hardware.nix
    ];

  boot.initrd.availableKernelModules = [ "battery" ];
  boot.kernelPackages = pkgs.linuxPackages_latest; # use the latest kernel
  boot.blacklistedKernelModules = [ "nouveau" ]; # blacklist the opensource nvidia driver

  hardware.logitech = {
    enable = true;
    enableGraphical = true;
  };

  hardware.trackpoint.device = "TPPS/2 Elan TrackPoint";

  hardware.enableAllFirmware = true;

  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max";
    editor = false;
  };

  boot.loader.efi.canTouchEfiVariables = true;


  boot.supportedFilesystems = [ "zfs" ];

  boot.zfs = {
    enableUnstable = true;
    requestEncryptionCredentials = true;
  };

  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  services.zfs = {
    trim.enable = true; # good for ssds!
    autoScrub.enable = true;
    autoSnapshot.enable = true;
  };

  fonts = {
    fontconfig.dpi = 192;
    fontconfig.penultimate.enable = true;
    fonts = with pkgs; [
      ibm-plex
    ];
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

  powerManagement.powertop.enable = true;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true; # need this for steam
  };

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
        extraConfig = (builtins.readFile mini-greeter/mini-greeter.conf);
      };
    };
    displayManager.defaultSession = "none+bspwm";
    desktopManager.xterm.enable = false;
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    libinput.enable = true;
    windowManager.bspwm = {
      enable = true;
    };
    videoDrivers = [ "intel" ]; # change this to "nvidia" to use the nvidia card
  };

  hardware.nvidia = {
    optimus_prime.enable = true;
    modesetting.enable = true;
    optimus_prime.nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };


  nixpkgs.config.allowUnfree = true;

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

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz"; # readable on high dpi displays
    keyMap = "us";
  };

  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    keybase-gui
    vanilla-dmz
    hicolor-icon-theme
  ];

  programs.zsh.enable = true;


  users.extraUsers.patrl = {
    description = "Patrick Elliott";
    createHome = true;
    # note that I need to be in the audio group for mopidy
    extraGroups = [ "wheel" "networkmanager" ];
    isNormalUser = true;
    uid = 1000;
  };

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  security.sudo.wheelNeedsPassword = false;

  hardware.cpu.intel.updateMicrocode = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

  services.throttled.enable = true;

  services.redshift.enable = true;

  location = {
    latitude = 42.4;
    longitude = 71.1;
  };

  services.keybase.enable = true;
  services.kbfs.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    package = pkgs.bluezFull;
  };

  programs.ssh.askPassword = "";

  services.compton.enable = true;
  services.compton.shadow = true;
  services.compton.inactiveOpacity = "0.8";

  services.blueman.enable = true;

}
