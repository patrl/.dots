{config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    neovim
    # python36Packages.neovim
      # needed for neovim clipboard
    xsel
  ];

}
