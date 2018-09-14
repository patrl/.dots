{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

  # cargo
  # rustc
  rustup

  ];

}
