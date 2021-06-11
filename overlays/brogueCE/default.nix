{ lib, stdenv, fetchurl, fetchFromGitHub, SDL2, SDL2_image, makeDesktopItem }:

stdenv.mkDerivation rec {
  pname = "brogue-ce";
  version = "1.9.3";

  hardeningDisable = [ "format" ];

  src = fetchFromGitHub {
		owner = "tmewett";
		repo = "BrogueCE";
		rev = "v1.9.3";
    sha256 = "1n6i6np8ddbi1w9p33qwq4rq4prwk0ykr8zs1079j7hlj0nhpam4";
  };

  prePatch = ''
		sed -i Makefile -e 's,-Wno-format,,g'
		sed -i config.mk -e 's,DATADIR := .,DATADIR := '$out'/share/brogue,g'
		sed -i linux/brogue-multiuser.sh -e 's,broguedir="/opt/brogue",broguedir="'$out'/bin",'
		sed -i linux/brogue-multiuser.sh -e 's,exec "$broguedir"/brogue,exec "$broguedir"/brogue.real,'
    make clean
  '';

  buildInputs = [ SDL2 SDL2_image ];

  desktopItem = makeDesktopItem {
    name = "brogue";
    desktopName = "Brogue";
    genericName = "Roguelike";
    comment = "Brave the Dungeons of Doom! (Community Edition)";
    icon = "brogue";
    exec = "brogue";
    categories = "Game;AdventureGame;";
    terminal = "false";
  };

  installPhase = ''
    install -m 555 -D bin/brogue $out/bin/brogue.real
		install -m 555 -D linux/brogue-multiuser.sh $out/bin/brogue
    install -m 444 -D ${desktopItem}/share/applications/brogue.desktop $out/share/applications/brogue.desktop
    install -m 444 -D bin/assets/icon.png $out/share/icons/hicolor/256x256/apps/brogue.png
    mkdir -p $out/share/brogue
    cp -r bin/assets $out/share/brogue/
  '';

  meta = with lib; {
    description = "A roguelike game (brogue community edition)";
    homepage = "https://github.com/tmewett/BrogueCE";
    license = licenses.agpl3;
    maintainers = [ maintainers.benob ];
    platforms = [ "x86_64-linux" ];
  };
}
