{ pkgs, ... }:

{
  enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };
}
