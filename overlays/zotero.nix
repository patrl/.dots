self: super:
{
  zotero = super.zotero.overrideAttrs ( old: rec {
    version = "5.0.85";
    src = super.fetchurl {
    url = "https://download.zotero.org/client/release/5.0.85/Zotero-5.0.85_linux-x86_64.tar.bz2";
    sha256 = "0zqc27kld7rm3akmrnf9ba1x2hb9838cbv6i3nkqvg81ly5gfbxs";
    # date = 2020-04-08T12:41:23-0400;
  };
  });
}
