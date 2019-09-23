{ config, pkgs, ... }:

{
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
  };
}
