{config, pkgs, ... }:


{

  services.xserver.windowManager.bspwm = {
    enable = true;
    # package = unstable.bspwm;
    # sxhkd.package = unstable.sxhkd;
  };

  environment.systemPackages = with pkgs; [
    polybar
  ];

}
