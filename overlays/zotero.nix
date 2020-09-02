self: super:
{
  zotero = super.zotero.overrideAttrs ( old: rec {
    version = "5.0.88";
    src = super.fetchurl {
    url = "https://download.zotero.org/client/release/5.0.88/Zotero-5.0.88_linux-x86_64.tar.bz2";
    sha256 = "19r9jmakr04raqripfnqm2b9gwpi52lklrrqgqyb1x35a4xvnj62";
    # date = 2020-07-12T13:44:52-0400;
  };
  });
}
