{config, pkgs, ... }:

{

  # nixpkgs.config.packageOverrides = pkgs: {
    # keybase = unstable.keybase;
    # kbfs = unstable.kbfs;
  # };


  environment.systemPackages = with pkgs; [
    keybase-gui
  ];


  services.keybase.enable = true;
  services.kbfs.enable = true;

}
