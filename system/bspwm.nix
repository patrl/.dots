{config, pkgs, ... }:


let
  unstable = import <nixos-unstable> { config = { allowUnfree = true;  }; };
in {

  services.xserver.windowManager.bspwm = {
    enable = true;
    # configFile = ./bspwm/.config/bspwm/bspwmrc;
    # sxhkd.configFile = ./bspwm/.config/sxhkd/sxhkdrc;
    package = unstable.bspwm;
    sxhkd.package = unstable.sxhkd;
  };

  services.xserver.windowManager.default = "bspwm";

  environment.systemPackages = with pkgs; [
    unstable.polybar
  ];

}
