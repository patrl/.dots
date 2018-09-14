{config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

  nixpkgs.config.packageOverrides = pkgs: {
    syncthing = unstable.syncthing;
  };


  services.syncthing.enable = true;
  services.syncthing.systemService = false;

}
