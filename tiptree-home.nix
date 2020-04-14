{ config, pkgs, ... }:

{

  imports = [
    ./common.nix
    ./tex.nix
  ];

programs.emacs = {
  package = pkgs.emacs26-nox;
};

services.gpg-agent = {
  pinentryFlavor = null;
  extraConfig = ''
  pinentry-program /home/patrl/repos/pinentry-wsl-ps1/pinentry-wsl-ps1.sh
  '';
};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";

}
