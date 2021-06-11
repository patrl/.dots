{ lib
, stdenv
, requireFile
, unzip
, makeDesktopItem
, SDL2
, xorg
, libpulseaudio
, systemd }:

let
  arch = "amd64";

  sha256 = "1c6ph5hjd2c493jz52mp84hw8l7jayrxcv3a8s0x9amv3spnw12j";

  desktopItem = makeDesktopItem {
    desktopName = "pico-8";
    genericName = "pico-8 virtual console";
    categories = "Game;";
    exec = "pico8";
    icon = "lexaloffle-pico8";
    name = "pico8";
    type = "Application";
  };

in

stdenv.mkDerivation rec {
  pname = "pico-8";
  version = "0.2.2c";

  helpMsg = ''
    We cannot download the full version automatically, as you require a license.
    Once you have bought a license, you need to add your downloaded version to the nix store.
    You can do this by using "nix-prefetch-url file://\$PWD/${pname}_${version}_${arch}.zip"
    in the directory where you saved it.
  '';

  src = requireFile {
    message = helpMsg;
    name = "${pname}_${version}_${arch}.zip";
    inherit sha256;
  };

  buildInputs = [ unzip ];
  phases = [ "unpackPhase" "installPhase" ];

  libPath = lib.makeLibraryPath [ stdenv.cc.cc.lib stdenv.cc.libc SDL2
    xorg.libX11 xorg.libXinerama libpulseaudio ];

  installPhase = ''
    mkdir -p $out/bin $out/lib $out/share/applications $out/share/icons/hicolor/128x128/apps
    install -t $out/bin -m755 -v pico8
    install -t $out/bin -m644 pico8.dat
    install -t $out/share/icons/hicolor/128x128/apps -m644 lexaloffle-pico8.png
    cp ${desktopItem}/share/applications/pico8.desktop \
      $out/share/applications/pico8.desktop
    ln -s ${systemd}/lib/libudev.so.1 $out/lib/libudev.so.1
    patchelf \
      --interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
      --set-rpath ${libPath}:$out/lib \
      $out/bin/pico8
  '';

  meta = with lib; {
    description = "Tiny 2D, 4-bit colour fantasy console.";
    homepage = "https://www.lexaloffle.com/pico-8.php";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ maxeaubrey ];
  };
}
