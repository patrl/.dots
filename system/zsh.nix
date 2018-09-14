{config, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
  };

  users.extraUsers.patrl.shell = pkgs.zsh;

}
