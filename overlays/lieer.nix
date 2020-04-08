self: super:
{
  gmailieer = super.gmailieer.overrideAttrs ( old: rec {
    name = "lieer-${version}";
    version = "1.0";
    src = super.fetchFromGitHub {
      owner = "gauteh";
      repo = "lieer";
      rev = "9095dd731316fbd5ebca1f95b14a1441f7dd7955";
      sha256 = "0hs1dvz50zc5rhhn40195d992lpc8nlz9kgn66650036pzpxzwyz";
      # date = 2020-04-04T10:09:55+02:00;
    };
  });
}
