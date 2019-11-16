{ config, pkgs, ... }:

let
  stable = import <nixos-stable> { config = { allowUnfree = true;  }; };
in
{

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
    stable.haskellPackages.cabal2nix
    haskellPackages.styx
    haskellPackages.brittany
    haskellPackages.structured-haskell-mode
    # unstable.haskellPackages.hpack
    # unstable.haskellPackages.dhall
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    haskellPackages.Agda
    # haskellPackages.hpack-dhall
    stack
    # haskellPackages.stack-run
  ];

}
