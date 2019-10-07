{config, pkgs, ... }:

{

  services.udev.packages = with pkgs; [ yubikey-personalization ];

  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
  ];

}
