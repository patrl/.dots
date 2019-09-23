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
    # unstable.haskellPackages.nix-tools
    haskellPackages.hlint
    haskellPackages.hasktags
    haskellPackages.apply-refact
    haskellPackages.cabal2nix
    haskellPackages.styx
    # (unstable.haskell.lib.dontCheck unstable.haskellPackages.brittany)
    haskellPackages.structured-haskell-mode
    # unstable.haskellPackages.hpack
    # unstable.haskellPackages.dhall
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    unstable.haskellPackages.Agda
    # haskellPackages.hpack-dhall
    unstable.stack
    # haskellPackages.stack-run
  ];

}
