{config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

  services.udev.packages = with pkgs; [ unstable.yubikey-personalization ];

  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    unstable.yubikey-manager
    unstable.yubikey-manager-qt
    unstable.yubikey-personalization
    unstable.yubikey-personalization-gui
  ];

}
