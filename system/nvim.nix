{config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

  environment.systemPackages = with pkgs; [
    unstable.neovim
    unstable.python36Packages.neovim
      # needed for neovim clipboard
    xsel
  ];

}
