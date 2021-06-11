{ lib, stdenv, fetchurl, pkgconfig, SDL2, libogg, libvorbis, zlib, unzip }:

let

  # Digital recordings of the music on an original Roland MT-32.  So
  # we don't need actual MIDI playback capability.
  audio = fetchurl {
    url = "mirror://sourceforge/exult/exult_audio.zip";
    sha256 = "0s5wvgy9qja06v38g0qwzpaw76ff96vzd6gb1i3lb9k4hvx0xqbj";
    # date = 2020-06-02T10:20:33-0400;
  };

in

stdenv.mkDerivation rec {
  name = "exult-1.6";

  src = fetchurl {
    url = "mirror://sourceforge/exult/exult-1.6.tar.gz";
    sha256 = "1dm27qkxj30567zb70q4acddsizn0xyi3z87hg7lysxdkyv49s3s";
    # date = 2020-06-02T10:23:38-0400;
  };

  configureFlags = [ "--disable-tools" ];

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ SDL2 libogg libvorbis zlib unzip ];

  enableParallelBuilding = true;

  # makeFlags = [ "DESTDIR=$(out)" ];

  NIX_LDFLAGS = "-lX11";

  postInstall =
    ''
      mkdir -p $out/share/exult/music
      unzip -o -d $out/share/exult ${audio}
      chmod 644 $out/share/exult/*.flx
    ''; # */

  meta = with lib; {
    homepage = "http://exult.sourceforge.net/";
    description = "A reimplementation of the Ultima VII game engine";
    maintainers = [ maintainers.eelco ];
    platforms = platforms.unix;
    hydraPlatforms = platforms.linux; # darwin times out
    license = licenses.gpl2Plus;
  };
}
