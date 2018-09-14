{config, pkgs, ... }:

let
    unstable = import <nixos-unstable> { config = { allowUnfree = true;  }; };
in {
  # Note that I still need to get matrix and slack working.

  environment.systemPackages = with pkgs; [
    # weechat
    # need these for weechat SASL
    openssl
    xxd
    # pythonPackages.websocket_client
    # YAS finally got the wee-slack working.
    unstable.weechat

  ];

}
