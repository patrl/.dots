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
    haskellPackages.hindent
    haskellPackages.hasktags
    haskellPackages.apply-refact
    haskellPackages.cabal2nix
    haskellPackages.styx
    haskellPackages.brittany
    haskellPackages.structured-haskell-mode
    unstable.haskellPackages.hpack
    unstable.haskellPackages.dhall
    unstable.haskellPackages.pandoc
    unstable.haskellPackages.pandoc-citeproc
    unstable.haskellPackages.Agda
    # haskellPackages.hpack-dhall
    unstable.stack
    # haskellPackages.stack-run
  ];

}
