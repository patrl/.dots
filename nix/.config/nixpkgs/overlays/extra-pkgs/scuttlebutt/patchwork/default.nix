{ stdenv, lib, fetchurl, glibc, zlib, fuse, cairo, atk,
  pythonPackages, p7zip, udev, dbus, gtk3, pango,
  gdk_pixbuf, glib, libX11, libXScrnSaver, libXcomposite, libXcursor,
  libXdamage, libXext, libXfixes, libXi, libXrandr, libXrender, libXtst,
  libxcb, gnome2, nss, nspr, alsaLib, cups, fontconfig, expat, makeDesktopItem}:

let
  rpath = lib.makeLibraryPath [
    alsaLib
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    fuse
    gdk_pixbuf
    glib
    gtk3
    gnome2.GConf
    libX11
    libXScrnSaver
    libXcomposite
    libXcursor
    libxcb
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXtst
    nspr
    nss
    pango
    stdenv.cc.cc
    udev
    zlib.out
  ];

in stdenv.mkDerivation rec {
  name = "patchwork-${version}";
  version = "3.11.6";

  src = fetchurl {
    url = "https://github.com/ssbc/patchwork/releases/download/v${version}/${name}-linux-x86_64.AppImage";
    sha256 = "1d2rq6l2mbi6bqv8321ps5bi9n8aqriwv7agc2zvgylm0cxyc4cq";
  };

  desktopItem = makeDesktopItem {
    name = "Patchwork";
    exec = "patchwork";
    icon = "$out/share/patchwork/";
    comment = "Decentralized messanging and sharing app";
    desktopName = "Patchwork";
    genericName = "Patchwork";
    categories = "Network;";
  };

  binwalk = "${pythonPackages.binwalk}/bin/binwalk";

  unpackPhase = ''
    export HOME=$(pwd) # binwalk seems unhappy without this...
    ${binwalk} $src --quiet -D 'squashfs:.squashfs:7z x %e'
    '';

  installPhase = ''
    #
    # appName is kind of a hack. Binwalk extracted
    # the retrieved squashfs in a directory named after the
    # AppImage name (_$imagename.extracted to be exact),
    # which itself depends of its name in the nix store.
    #
    # I did not find a way to extract the data without this
    # weird folder name.
    #
    # So we are basically looking for the name of the AppImage drv here (without the .drv)
    # to predict this directory name.
    #
    appName=$(basename -s .drv $src)
    mkdir -p $out/{bin,share,share/applications}
    cd _$appName.extracted
    cp ssb-patchwork.png $out/share/patchwork.png
    cp -r app/* $out/share/
    chmod a+x $out/share/ssb-patchwork
    ln -s $out/share/ssb-patchwork $out/bin/ssb-patchwork
    ln -s ${desktopItem}/share/applicatinos/* $out/share/applications/
  '';

  fixupPhase = ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath ${rpath}:$out/share \
      $out/share/ssb-patchwork
  '';

  meta = {
    description = "A decentralized messaging and sharing app built on top of Secure Scuttlebutt (SSB)";
    homepage    = https://github.com/ssbc/patchwork;
    license     = lib.licenses.agpl3;
    maintainers = with lib.maintainers; [ ninjatrappeur ];
    platforms   = [ "x86_64-linux" ];
  };
}
