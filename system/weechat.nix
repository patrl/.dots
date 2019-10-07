{config, pkgs, ... }:

{
  # Note that I still need to get matrix and slack working.

  environment.systemPackages = with pkgs; [
    # need these for weechat SASL
    openssl
    xxd
    weechat

  ];

}
