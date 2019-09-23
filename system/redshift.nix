{config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

  nixpkgs.config.packageOverrides = pkgs: {
    geoclue2 = unstable.geoclue2;
  };


  environment.systemPackages = with pkgs; [
    unstable.redshift
  ];


  # services.geoclue2.enable= true;

  services.redshift.enable = true;
  services.redshift.provider = "manual";
  services.redshift.latitude = "42.3736158";
  services.redshift.longitude = "-71.1097335";
  # services.geoclue2.enable = true;

  # environment.systemPackages = with pkgs; [
    # redshift
  # ];

}
