{config, pkgs, ... }:


let
  unstable = import <nixos-unstable> { config = { allowUnfree = true;  }; };
in {

  services.xserver.windowManager.bspwm = {
    enable = true;
    package = unstable.bspwm;
    sxhkd.package = unstable.sxhkd;
  };

  environment.systemPackages = with pkgs; [
    unstable.polybar
  ];

}
