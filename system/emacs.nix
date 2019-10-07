{config, pkgs, ... }:

{

   services.emacs = {
     # defaultEditor = true;
     enable = true;
     # package = emacs;
   };

  environment.systemPackages = with pkgs; [
    # needed for emacs spellchecking.
    aspell
    aspellDicts.en
    # needed for mu4e
    isync
    mu
    gnutls
  ];
}
