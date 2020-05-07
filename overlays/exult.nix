self: super:
{
  exult = super.exult.overrideAttrs ( old: rec {
    name = "exult-1.6";
    src = super.fetchurl {
      url = "mirror://sourceforge/exult/exult-1.6.tar.gz";
      sha256 = "1dm27qkxj30567zb70q4acddsizn0xyi3z87hg7lysxdkyv49s3s";
      # date = 2020-04-30T00:37:49-0400;
    };
  });
}
