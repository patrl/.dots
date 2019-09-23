{config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

   services.emacs = {
     # defaultEditor = true;
     enable = true;
     package = unstable.emacs;
   };

  environment.systemPackages = with pkgs; [
    # needed for emacs spellchecking.
    aspell
    aspellDicts.en
    # needed for mu4e
    unstable.isync
    unstable.mu
    gnutls
  ];
}
