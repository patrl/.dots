{config, pkgs, ... }:

{
  # Note that I still need to get matrix and slack working.

  environment.systemPackages = with pkgs; [
    steam
  ];

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

}
