{config, pkgs, ... }:

{
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.192.122.3/32" ];
      peers = [ {
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "207.246.88.223:51820";
        publicKey = "FSLCOWmAO4uOfyMg1SP90MKgKr5fV9jQ4B2qaPoRIjE=";
        persistentKeepalive = 25;
      } ];
      privateKey = "qBCYQseanLpNNbRI7u2R0jaHRqAd3VkFvJCaD40pJnI=";
      preSetup = [ ''${config.system.path}/bin/echo nameserver 10.192.122.1 | ${config.system.path}/bin/resolvconf -a tun.wg0 -m 0 -x'' ];
      # postSetup = [ ''${config.system.path}/bin/echo nameserver 10.192.122.1 | ${config.system.path}/bin/resolvconf -a tun.wg0 -m 0 -x'' ];
      postShutdown = [ ''${config.system.path}/bin/resolvconf -d tun.wg0'' ];
    };
  };

}
