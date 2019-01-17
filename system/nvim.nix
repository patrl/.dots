{config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

  environment.systemPackages = with pkgs; [
    neovim
    python36Packages.neovim
      # needed for neovim clipboard
    xsel
  ];

}
