{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  environment.systemPackages = with pkgs; [

    haskellPackages.ghc
    haskellPackages.hoogle
    # haskellPackages.ghc-mod
    # haskell.packages.ghc802.ghc-mod
    haskellPackages.cabal-install
    haskellPackages.hlint
    haskellPackages.hasktags
    haskellPackages.apply-refact
    haskellPackages.cabal2nix
    haskellPackages.styx
    # unstable.haskellPackages.brittany # FIXME
    haskellPackages.structured-haskell-mode
    unstable.haskellPackages.hpack
    unstable.haskellPackages.dhall
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    unstable.haskellPackages.Agda # FIXME
    # haskellPackages.hpack-dhall
    unstable.stack
    # haskellPackages.stack-run
  ];

}
