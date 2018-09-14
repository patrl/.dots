{config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (pkgs.st.override { patches = builtins.map fetchurl [
      {
        url = "https://gist.github.com/patrl/3be6f35baf172064946b2fb06862c9b1/raw/f9d4cd9d4ca24e00b0128c51b61b7c4070682256/patrl-st-0.8.diff";
        sha256 = "8e6efa33fe9bc9a5f43789a6139c3c54fc7730c9189e5ae91edb3d81b91b4ee9";
      }
      {
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.8.diff";
        sha256 = "8279d347c70bc9b36f450ba15e1fd9ff62eedf49ce9258c35d7f1cfe38cca226";
      }
      {
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.8.diff";
        sha256 = "3fb38940cc3bad3f9cd1e2a0796ebd0e48950a07860ecf8523a5afd0cd1b5a44";
      }
    ];
    })
    ];

}
