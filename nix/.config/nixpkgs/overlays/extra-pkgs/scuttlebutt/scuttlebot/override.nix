{pkgs ? import <nixpkgs> {
    inherit system;
}, system ? builtins.currentSystem}:

let
  nodePackages = import ./default.nix {
    inherit pkgs system;
  };
in
nodePackages // {
  scuttlebot = nodePackages.scuttlebot.override {
    buildInputs = [ pkgs.automake pkgs.autoconf pkgs.nodePackages.node-gyp-build ];
  };
}
