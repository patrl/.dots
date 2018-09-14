{config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

  nixpkgs.config.packageOverrides = pkgs: {
    keybase = unstable.keybase;
    kbfs = unstable.kbfs;
  };


  environment.systemPackages = with pkgs; [
    unstable.keybase-gui
  ];


  services.keybase.enable = true;
  services.kbfs.enable = true;

}
