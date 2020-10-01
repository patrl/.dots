{ buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "twad";
  version = "0.11.0";

  goPackagePath = "github.com/zmnpl/twad";

  src = fetchFromGitHub {
    owner = "zmnpl";
    repo = "twad";
    rev = "62f9f22911fd367864da0ec44a0c670dc7fb6056";
    sha256 = "072rws0n5dqim0zl087ifmw3w0pf5pzkv6pszxskijch6kiab8nc";
    # date = 2020-10-01T20:33:45+02:00;
  };

  goDeps = ./deps.nix;

  modSha256 = null;

  subPackages = [ "." ];
}
