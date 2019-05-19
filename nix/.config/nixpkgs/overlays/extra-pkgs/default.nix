# I use this overlay to add some packages missing
# in nixpkgs.
#
# Why are they not upstreamed? Either I tried and the PR
# was not accepted, either the package is too hacky as it is
# to be upstreamed.
#
self: super:
{
  extra-pkgs = {
    patchwork = super.callPackage ./scuttlebutt/patchwork {};
    scuttlebot = super.callPackage ./scuttlebutt/scuttlebot {};
    beakerbrowser = super.callPackage ./beakerbrowser {};
  };
}
