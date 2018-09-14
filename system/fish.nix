{config, pkgs, ... }:

{

  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
  };

  # users.extraUsers.patrl.shell = pkgs.fish;

  }
