{config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    wireguard
  ];

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.200.200.2/32" ];
      peers = [ {
        # allowedIPs = [ "0.0.0.0/0" ];
        allowedIPs = [ "10.200.200.1" ];
        endpoint = "149.28.232.171:51820";
        publicKey = "1Lm0wUz84nriFsWxlWJ5n0OggxvTF6HEy2mBeBtWOzw=";
        persistentKeepalive = 25;
      } ];
      privateKeyFile = "/home/patrl/wireguard-keys/private";
    };
  };

}
