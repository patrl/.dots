{config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

  # This was needed to fix a bug with emacs failing to start.
  # environment.variables.NO_AT_BRIDGE = "1";

   services.emacs = {
     defaultEditor = true;
     enable = true;
     package = unstable.emacs;
   };

  environment.systemPackages = with pkgs; [
    # emacs26
    # needed for emacs spellchecking.
    aspell
    aspellDicts.en
    # needed for mu4e
    unstable.isync
    unstable.mu
    gnutls
  ];

   # nixpkgs.overlays = [(pkgs: super: {
   #                      emacs26 = pkgs.emacs.overrideAttrs (oldAttrs : {
   #                                                             version = "26.1RC1";
   #                                                             src = pkgs.fetchurl {
   #                                                             url = "ftp://alpha.gnu.org/gnu/emacs/pretest/emacs-26.1-rc1.tar.xz";
   #                                                             sha256 = "6594e668de00b96e73ad4f168c897fe4bca7c55a4caf19ee20eac54b62a05758";
   #                                                             };
   #                                                             patches = [];
   #                                                             });

   #                      emacsWithPackages = (pkgs.emacsPackagesNgGen pkgs.emacs26).emacsWithPackages;

   #                                    }
   #                     )
   #                     ];

}
