# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only

  networking.firewall = {
                      enable = true;
                      rejectPackets = true;
                      allowPing = true;
                      allowedTCPPorts = [ 80 443 3282 ];
                      allowedUDPPorts = [ 3282 ];
  };

  networking.hostName = "toren"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  systemd.services.homebase = {
                            after = [ "syslog.target" "network.target" "remote-fs.target" "nss-lookup.target" ];
                            description = "homebase";
                            serviceConfig = {
                                            ExecStart = "/run/current-system/sw/bin/node /home/patrl/.node_modules/bin/homebase";
                                            Restart = "always";
                                            User = "patrl";
                                            Group = "users";
                                            WorkingDirectory="/home/patrl";
                                            };
                            # environment = { PATH = ''/home/patrl/bin:/run/wrappers/bin:/etc/profiles/per-user/patrl/bin:/home/patrl/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:/home/patrl/.node_modules/bin''; };
                            wantedBy = [ "multi-user.target" ];

};

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    nodejs-8_x
    gcc
    gnumake
    lsof
    htop
    git
  ];

  services.nginx = {
                 enable = true;
                 recommendedGzipSettings = true;
                 recommendedOptimisation = true;
                 recommendedProxySettings = true;
                 recommendedTlsSettings = true;
                 virtualHosts."patrickdelliott.com" = {
                   enableACME = true;
                   forceSSL = true;
                   location."/.well-known/acme-challenge".extraConfig = ''
                     root /var/www/challenges;
                     '';
                   locations."/".extraConfig = ''
                     proxy_pass http://localhost:8080/;
                     proxy_set_header X-Real-IP $remote_addr;
                     return 301 https://$host$request_uri;
                   '';
                 };
  };

  security.acme.certs."patrickdelliott.com" = {
    webroot = "/var/www/challenges";
    email = "patrick.d.elliott@gmail.com";
  };

  programs.zsh = {
               enable = true;
               enableCompletion = true;
               interactiveShellInit = ''
                                      export npm_config_prefix=~/.node_modules
                                      path+=('/home/patrl/.node_modules/bin')
				                              if [[ "$TERM" == "dumb" ]]
				                              then
  					                            unsetopt zle
  					                            unsetopt prompt_cr
  					                            unsetopt prompt_subst
  					                            unfunction precmd
  					                            unfunction preexec
  					                            PS1='$ '
				                              fi
                                      '';
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.patrl = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    extraGroups = [ "wheel" ];
    description = "Patrick Elliott";
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
