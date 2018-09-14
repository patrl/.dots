{config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (pkgs.st.override { patches = builtins.map fetchurl [
      {
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.7.diff";
        sha256 = "f721b15a5aa8d77a4b6b44713131c5f55e7fca04006bc0a3cb140ed51c14cfb6";
      }
      {
        url= "https://st.suckless.org/patches/dracula/st-dracula-20170803-7f99032.diff";
        sha256="4840b814dfa6c38f2aea87e622e1aaa255e411226907b50fb60623d2c70b01d4";
      }
    ];
    })
    ];

}
