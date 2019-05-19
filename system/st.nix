{config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (pkgs.st.override { patches = builtins.map fetchurl [
      {
        url = "https://st.suckless.org/patches/dracula/st-dracula-0.8.2.diff";
        sha256 = "5eb8e0375fda9373c3b16cabe2879027300e73e48dbd9782e54ffd859e84fb7e";
      }
      # {
        # url = "https://gist.githubusercontent.com/patrl/d30de19086ec470e8f208b3d64540b14/raw/5b4b6088bbd940bc0b613173088c387837aedfcc/st-dracula-0.8.2.diff";
        # sha256 = "e906484331d6607d2d936da0bd9a34f5f7eb25b0d38eab1d50c64055220d27e5";
      # }
      {
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.8.2.diff";
        sha256 = "9c5aedce2ff191437bdb78aa70894c3c91a47e1be48465286f42d046677fd166";
      }
      {
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.8.2.diff";
        sha256 = "6103a650f62b5d07672eee9e01e3f4062525083da6ba063e139ca7d9fd58a1ba";
      }
    ];
    })
    ];

}
