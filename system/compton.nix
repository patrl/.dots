{ config, pkgs, ... }:

{

  services.compton = {
    backend         = "glx";
    enable          = true;
    fade            = true;
    fadeDelta       = 8;
    fadeSteps       = [ "0.04" "0.04" ];
    inactiveOpacity = "0.8";
    shadow          = true;
    # extraOptions = ''
    # no-dock-shadow = false;
    # glx-no-stencil = true;
    # paint-on-overlay = true;
    # '';
  };

}
