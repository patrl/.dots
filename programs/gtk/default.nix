{ pkgs, ... }:

{
  enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      package = pkgs.adapta-gtk-theme;
      name = "Adapta-Nokto";
    };
}
