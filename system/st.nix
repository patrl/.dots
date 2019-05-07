{config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (pkgs.st.override { patches = builtins.map fetchurl [
      {
        url = "https://gist.githubusercontent.com/patrl/d30de19086ec470e8f208b3d64540b14/raw/5b4b6088bbd940bc0b613173088c387837aedfcc/st-dracula-0.8.2.diff";
        sha256 = "e906484331d6607d2d936da0bd9a34f5f7eb25b0d38eab1d50c64055220d27e5";
      }
      # {
        # url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.8.diff";
        # sha256 = "8279d347c70bc9b36f450ba15e1fd9ff62eedf49ce9258c35d7f1cfe38cca226";
      # }
      # {
        # url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.8.diff";
        # sha256 = "3fb38940cc3bad3f9cd1e2a0796ebd0e48950a07860ecf8523a5afd0cd1b5a44";
      # }
    ];
    })
    ];

}
