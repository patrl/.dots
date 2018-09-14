{config, pkgs, ... }:

{

  services.redshift.enable = true;
  services.redshift.provider = "geoclue2";

  environment.systemPackages = with pkgs; [
    geoclue2
  ];


}
